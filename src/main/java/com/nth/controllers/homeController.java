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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class homeController {

    private final PostMapper postMapper;

    private final PostService postService;

    private final CommentsService commentsService;

    private final UserInfoService userInfoService;
    private final LikeService likeService;
    private static final Logger log = LoggerFactory.getLogger(homeController.class);

    @GetMapping("/")
    public String root(Principal principal){
        log.info("root()실행됨\n현재경로: / ");
        if(principal==null){
            log.info("로그인정보메세지\n현재로그인되어있지않습니다.");
        }else{
            log.info("로그인정보메세지\n현재 로그인 되어있습니다\n로그인 계정:{}",principal.getName());
        }
        return "home";
    }

    @GetMapping("/post")
    public String getPostList(Model model,
                              @RequestParam(defaultValue = "1") int page,
                              @RequestParam(defaultValue = "1") int range) {
        log.info("GetMapping(\"/post\")가 호출됨");
        int listCnt = postService.getPostCount(); // 전체 게시글 수
        Pagination pagination = new Pagination();
        pagination.pageInfo(page, range, listCnt);
        //pagination.pageconfig(5 ,5); 페이지 설정

        List<Post> postList = postService.getPostList(pagination);
        model.addAttribute("postList", postList);
        model.addAttribute("pagination", pagination);
        return "postList";
    }

    //게시글 상세보기
    @GetMapping("/post/{id}")
    public String getPostById(@PathVariable long id, Model model) {
        //Post post = postMapper.getPostById(id);
        model.addAttribute("formActionUrl", "/comments"); //게시글의 댓글을 위해 추가함
        Post post = postService.getPostById(id);

        List<Comments> comments = commentsService.getCommentsByPostId(id); // 댓글출력

//        log.info("@GetMapping(\"/post/{id}\") 가 실행되었습니다.\n\n"+
//                 "post.getTitle():{}"+post.getTitle()+
//                "\npost.getContent(){}:"+post.getContent()+
//                "\npost.getId():{}"+post.getId()+
//                "\n 날짜 :{}"+post.getCreatedDate()+
//
//                "\npost.getUserInfo():{}"+post.getUserInfo().getUsername()
      //  ); // 불러온글 로그
        Long Likecount = likeService.countLike(post.getId());
        model.addAttribute("like", Likecount); // 게시글추천데이터
        model.addAttribute("post", post); // 게시글데이터
        model.addAttribute("comments", comments); //댓글 데이터
        return "post_detail";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/create")
    public String createPost(@Valid PostForm postForm,BindingResult result,Principal principal
    ,Model model, RedirectAttributes redirectAttributes) {

        String errorResult = validateCheck(result,postForm,redirectAttributes);
        if (errorResult != null) {
            return errorResult;
        } // 유효성 검사
           UserInfo userInfo = userInfoService.findByUsername(principal.getName());
           Post post = postService.createIdPost(postForm, userInfo);
           Long postid = post.getId();
           return "redirect:/post/"+postid;
        }

        @PreAuthorize("isAuthenticated()")
        @GetMapping("/create")
        public String showPostForm(Model model) {
            model.addAttribute("formActionUrl", "/create");
        return "postcreate";}
        //삭제
         @GetMapping("/post/delete/{id}")
        public String deletePost(@PathVariable long id, Principal principal, RedirectAttributes redirectAttributes){
        log.info("/post/delete/{}요청이 들어왔습니다.",id);
        Post post = postService.getPostById(id);
        String redirectPage = checkAuthorAccess(post, principal, redirectAttributes,"삭제");
            if (redirectPage != null) {
            return redirectPage;
             }
             postService.deletePost(id);
        return "redirect:/post";
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
        model.addAttribute("formActionUrl", "/post/modify/" + id);
        model.addAttribute("postForm", postForm);
        return "postcreate";
    }

    @PostMapping("/post/modify/{id}")
    public String modifyPost(@PathVariable long id, @Valid PostForm postForm, BindingResult result) {
        log.info("/post/modifySubmit/{} 요청이 들어왔습니다. (POST)", id);
        if (result.hasErrors()) {
            return "postcreate";
        }
        Post post = postService.getPostById(id);
        post.setTitle(postForm.getTitle());
        post.setContent(postForm.getContent());
        postService.updatePost(id, post);
        return "redirect:/post/" + id;
    }



    public String checkAuthorAccess(Post post,Principal principal, RedirectAttributes redirectAttributes,
                                                 String errorMessage) {
        if (principal == null) {
            log.info("checkPostPermissionAndRedirect()실행됨\n" +
                    "인증되지 않은 사용자에 의한 시도." +
                    "\n요청된 게시글 작성자: {}" +
                    "\n현재 로그인상태 : {}", post.getUserInfo().getUsername(), !(principal == null));
            redirectAttributes.addFlashAttribute("errorMessage", "게시글"+errorMessage +"권한이 없습니다.1");
            return "redirect:/post/" + post.getId();
        } else if (!post.getUserInfo().getUsername().equals(principal.getName())) {
            log.info("checkPostPermissionAndRedirect()메소드 실행됨\n" +
                    "\n요청된 게시글 작성자:{}" +
                    "\n현재 로그인한 사용자:{}", post.getUserInfo().getUsername(), principal.getName());
            redirectAttributes.addFlashAttribute("errorMessage", "게시글"+errorMessage +"권한이 없습니다.1");
            return "redirect:/post/" + post.getId();
        }
        return null;
        }


    private String validateCheck(BindingResult bindingResult,PostForm postForm, RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            // 폼 검증 실패 시 에러 메시지 추가
            redirectAttributes.addFlashAttribute("commentForm",postForm);
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());

            List<ObjectError> errors = bindingResult.getAllErrors();
            for (ObjectError error : errors) {
                log.info("댓글 작성실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n실패이유: {}", error.getDefaultMessage());
                redirectAttributes.addFlashAttribute("postForm",postForm);
                return "redirect:/create"; // 에러 발생 시 돌아갈 페이지
            }
        }
        return null;
    }




}

