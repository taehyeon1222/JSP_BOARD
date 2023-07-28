package com.nth.controllers;

import com.nth.domain.Comments;
import com.nth.domain.Like;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.CommentForm;
import com.nth.dto.PostForm;
import com.nth.mapper.PostMapper;
import com.nth.service.*;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class homeController {

    private final PostMapper postMapper;

    private final PostService postService;

    private final CommentsService commentsService;

    private final CommentsLikeService commentsLikeService;

    private final UserInfoService userInfoService;
    private final LikeService likeService;
    private static final Logger log = LoggerFactory.getLogger(homeController.class);
    @GetMapping("/home")
    public String test(Principal principal ){

        return "header-basic";
    }
    @GetMapping("/")
    public String root(Principal principal,Model model){
        log.info("root()실행됨\n현재경로: / ");
        if(principal==null){
            log.info("로그인정보메세지\n현재로그인되어있지않습니다.");
        }else{
            String username = principal.getName();
            log.info("로그인정보메세지\n현재 로그인 되어있습니다\n로그인 계정:{}",principal.getName());
            model.addAttribute("username",username);
        }


        return "home";
    }

    @GetMapping("/post")
    public String getPostList(Model model,
                              @RequestParam(defaultValue = "") String keyword,
                              @RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "1") int range,
                              @RequestParam(defaultValue = "title") String searchType,
                              @RequestParam(defaultValue = "공지") String category) {
        log.info("GetMapping(\"/post\")가 호출됨");

        Pagination pagination = new Pagination();
        List<Post> postList;
        int listCount;

        switch (searchType) {
            case "title":
                model.addAttribute("category", category); // 카테고리값 전달
                log.info("제목과 내용으로 검색");
                listCount = postService.getPostCountByTitleAndCategory(keyword, category); //총 게시글수
                pagination.pageInfo(page, range, listCount); //페이징 설정
                pagination.setTotalCount(listCount);//총 게시글 수

                postList = postService.searchPostTitleCategoryList(keyword, pagination, category); // 제목 내용
                break;
            case "userId":
                model.addAttribute("category", category); // 카테고리값 전달
                log.info("아이디로검색이 선택됨");
                listCount = postService.getPostCountByUserNameAndCategory(keyword,category); //총게시글 수
                pagination.pageInfo(page, range, listCount); //페이징 설정
                pagination.setTotalCount(listCount); // 총 게시글 수

                postList = postService.searchPostUsernameCategoryList(keyword,pagination,category); //유저이름
                break;
            default:
                throw new IllegalArgumentException("검색유형 오류: " + searchType);
        }

        model.addAttribute("keyword", keyword); // 키워드
        model.addAttribute("searchType", searchType); // 검색 타입
        model.addAttribute("pagination", pagination); // 페이징값
        model.addAttribute("postList", postList); // 검색결과 반환

        return "post/postList";
    }


    //게시글 상세보기
    @GetMapping("/post/{id}")
    public String getPostById(@PathVariable long id, Model model ,Principal principal) {
        Post post = postService.viewPost(id); //조회수 증가
        model.addAttribute("formActionUrl", "/comments"); //변동usl 편법으로 넣음
        List<Comments> comments = commentsService.getCommentsByPostId(id); //한개글 불러오기
        Map<Long, Long> commentLikes = new HashMap<>(); //댓글 좋아요 수 저장
        Map<Long, Boolean> commentEditPermissions = new HashMap<>(); //수정/삭제 편집권한을 저장할 맵

        boolean canEditPost =  AccessCheckPostButton(principal,post); //관리자권한 및 게시글작성자 와 접속유저 체크

        for (Comments comment : comments) {
            Long commentId = comment.getId();
            Long commentLikeCount = commentsLikeService.countLike(commentId); //댓글 좋아요수 저장
            commentLikes.put(commentId, commentLikeCount);

            boolean canEditComment = AccessCheckCommentButton(principal, comment); // 댓글 수정/삭제권한 체크 후 버튼 활성화
            commentEditPermissions.put(commentId, canEditComment);
        }

        Long LikeCount = likeService.countLike(post.getId());

        model.addAttribute("canEdit", canEditPost); //관리자권한 혹은 게시글 권한이 있을경우 수정/삭제 버튼 활성화
        model.addAttribute("commentEditPermissions", commentEditPermissions); //관리자권한 혹은 댓글 권한이 있을경우 수정/삭제 버튼 활성화
        model.addAttribute("commentLikeCount", commentLikes); //댓글좋아요수
        model.addAttribute("like", LikeCount); //게시글좋아요수
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);

        return "post/post_detail";
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/create")
    public String createPost(Model model) {
        model.addAttribute("formActionUrl", "/create");
        return "post/postcreate";}

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/create")
    public String createPost(@Valid PostForm postForm, BindingResult result, Principal principal, Model model, RedirectAttributes redirectAttributes) {
        String errorResult = validateCheck(result, postForm, redirectAttributes);
        // 유효성 검사 메서드
        if (errorResult != null) {
            return errorResult;
        }
        UserInfo userInfo = userInfoService.findByUsername(principal.getName());
        Post post = postService.createIdPost(postForm, userInfo);
        Long postid = post.getId();
        return "redirect:/post/"+postid;
    }

    //수정
    @GetMapping("/post/modify/{id}")
    public String modifyPost(@PathVariable long id, Model model,Principal principal, RedirectAttributes redirectAttributes) {
        log.info("/post/modify/{} 요청이 들어왔습니다. (GET)", id);
        Post post = postService.getPostById(id);

        String redirectPage = checkAuthorAccess(post,principal,redirectAttributes,"수정 ");
        if (redirectPage != null) {
            log.info("redirectPage가 실행됨");
            return redirectPage;
        }
        PostForm postForm = new PostForm();
        postForm.setTitle(post.getTitle());
        postForm.setContent(post.getContent());
        postForm.setCategory(post.getCategory());
        model.addAttribute("formActionUrl", "/post/modify/" + id);
        model.addAttribute("postForm", postForm);
        return "post/postcreate";
    }

    @PostMapping("/post/modify/{id}")
    public String modifyPost(@PathVariable long id, @Valid PostForm postForm, BindingResult result, Model model
    ,RedirectAttributes redirectAttributes) {
        log.info("/post/modifySubmit/{} 요청이 들어왔습니다. (POST)", id);

        String errorResult = validateCheck(result, postForm, redirectAttributes);
        // 유효성 검사 메서드
        if (errorResult != null) {
            return errorResult;
        }

        Post post = postService.getPostById(id);
        postService.updatePost(id,postForm);
        return "redirect:/post/" + id;
    }



    //삭제
         @GetMapping("/post/delete/{id}")
        public String deletePost(@PathVariable long id, Principal principal, RedirectAttributes redirectAttributes){
        log.info("/post/delete/{}요청이 들어왔습니다.",id);
        Post post = postService.getPostById(id);
        //게시물 수정및 삭제 버튼 강제 접근 처리
        String redirectPage = checkAuthorAccess(post, principal, redirectAttributes,"삭제");

            if (redirectPage != null) {
            return redirectPage;
             }

             postService.deletePost(id);
        return "redirect:/post";
        }


        /**
     * @param post
     * @param principal
     * @param redirectAttributes
     * @param errorMessage 에러메세지
     * @return 인증된 사용자인지 체크하고 리다이렉트 및 오류메세지
     */
    public String checkAuthorAccess(Post post,Principal principal, RedirectAttributes redirectAttributes,
                                                 String errorMessage) {
        if (principal == null) { //객체 검증
            log.info("checkPostPermissionAndRedirect()실행됨\n인증되지 않은 사용자에 의한 시도.\n요청된 게시글 작성자: {}\n현재 로그인상태 : {}", post.getUserInfo().getUsername(), !(principal == null));

            redirectAttributes.addFlashAttribute("errorMessage", "게시글"+errorMessage +"권한이 없습니다.1");
            return "redirect:/post/" + post.getId();
        // 어드민권한 체크
        } else if ((SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")))) {
            return null;
        }
        //작성자와 현재 접속한 유저 이름 체크
        else if (!post.getUserInfo().getUsername().equals(principal.getName())) {
            log.info("checkPostPermissionAndRedirect()메소드 실행됨\n요청된 게시글 작성자:{}\n현재 로그인한 사용자:{}", post.getUserInfo().getUsername(), principal.getName());
            redirectAttributes.addFlashAttribute("errorMessage", "게시글"+errorMessage +"권한이 없습니다.2");
            return "redirect:/post/" + post.getId();
        }
        return null;
        }



        /********************* 유 틸 *****************************/

    /**
     * @param principal
     * @param post
     * @return 어드민권한을 가지고 있을경우 작성자가 같을경우 프론트에서 수정/삭제버튼 활성화
     */
    public boolean AccessCheckPostButton(Principal principal, Post post){
        boolean canEditPost = SecurityContextHolder.getContext().getAuthentication().isAuthenticated() &&
                (SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")) ||
                        (principal != null && post.getUserInfo().getUsername().equals(principal.getName())));
        return canEditPost;
    }

    public boolean AccessCheckCommentButton(Principal principal,Comments comment){
        boolean canEditComment = SecurityContextHolder.getContext().getAuthentication().isAuthenticated() &&
                (SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")) ||
                        (principal != null && comment.getUserInfo().getUsername().equals(principal.getName())));
        return canEditComment;
    }

    /**
     * @param bindingResult 유효성 검사 결과
     * @param postForm 검증할 폼
     * @param redirectAttributes 에러메세지
     * @return 유효성 검사
     */
    private String validateCheck(BindingResult bindingResult,PostForm postForm, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            // 폼 검증 실패 시 에러 메시지 추가
            redirectAttributes.addFlashAttribute("postForm",postForm);
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());

            List<ObjectError> errors = bindingResult.getAllErrors();
            for (ObjectError error : errors) {
                log.info("작성실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n실패이유: {}", error.getDefaultMessage());
                redirectAttributes.addFlashAttribute("postForm",postForm);
                return "redirect:/create"; // 에러 발생 시 돌아갈 페이지
            }
        }
        return null;
    }


}

