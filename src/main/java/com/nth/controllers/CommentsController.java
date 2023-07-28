package com.nth.controllers;

import com.nth.domain.Comments;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.CommentForm;
import com.nth.service.CommentsService;
import com.nth.service.PostService;
import com.nth.service.UserInfoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class CommentsController {

    private final CommentsService commentsService;
    private final UserInfoService userInfoService;
    private final PostService postService;


    private static final Logger log = LoggerFactory.getLogger(CommentsController.class);


    @GetMapping("/comments")
    public String handleAction(@PathVariable long id, @PathVariable long postId, Model model) {
        log.info("/comments 겟맵핑이 발생함");
        return "redirect:/post/" + postId;
    }

    //댓글 작성
    @PostMapping("/comments")
    public String createComment(Comments comment, @RequestParam("postId") Long postId
            , Principal principal, RedirectAttributes redirectAttributes,
                                @Valid CommentForm commentForm, BindingResult result) {
        if (principal == null) {
            log.info("/comments 요청됨\n 요청에서 principal==null이 감지되었습니다.");
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/post/" + postId;
        }

        // 유효성 검사 후 에러 반환
        String errorResult = validateCheck(result, commentForm, redirectAttributes, postId);
        if (errorResult != null) {
            return errorResult;
        }

        UserInfo userInfo = userInfoService.findByUsername(principal.getName());
        commentsService.createComment(postId,commentForm, userInfo);
        return "redirect:/post/" + postId;

    }

    //댓글 삭제     /post/delete/${post.id}
    @GetMapping("/post/{postId}/delete/{id}")
    public String deleteComment(@PathVariable long id, @PathVariable long postId, RedirectAttributes redirectAttributes
    ,Principal principal) {
        Comments comment = commentsService.getCommentById(id);
        //Long postId = comment.getPostId(); //게시물의 id를 얻어옴
        if (comment == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글이 이미 삭제되었습니다.");
            log.error("접근하려는 댓글이 존재하지 않습니다." + id);
            return "redirect:/post/" + postId;
        }

        log.info("/post/Comment/delete/{} 삭제요청이 들어왔습니다\n게시물id:{}\n댓글id:{} 게시글작성자{}", id, postId, id,comment.getUserInfo().getUsername());//댓글삭제로그

        String authorityCheckResult = checkAuthorAccess(comment,principal,redirectAttributes,"수정",postId);
        if (authorityCheckResult != null) return authorityCheckResult; // 작성된 게시글과 로그인한 유저의 이름 및 권한을 체크하고 리다이렉트 해줍니다.

        // 댓글을 삭제합니다.
        commentsService.deleteComment(id);
        return "redirect:/post/" + postId;
    }

    @GetMapping("/post/{postId}/c/modify/{id}")
    public String ModifyComment(@PathVariable long id, @PathVariable long postId, Model model
            , RedirectAttributes redirectAttributes,Principal principal) {

        Comments updateComment = commentsService.getCommentById(id);
        log.info("/post/modify/{id} GET 수정요청이 들어왔습니다.\n게시물 id 값:{}\n댓글id값:{}",postId,id);

        if (updateComment == null) {
            log.error("댓글이 삭제 되어 댓글을 수정 할 수 없습니다. {} 접근 postid:{}",id,postId);
            redirectAttributes.addFlashAttribute("errorMessage", "댓글이 이미 삭제되었습니다.");
            return "redirect:/post/" + postId;
        }

        String authorityCheckResult = checkAuthorAccess(updateComment,principal,redirectAttributes,"수정",postId);
        if (authorityCheckResult != null)
            return authorityCheckResult; // 작성된 게시글과 로그인한 유저의 이름 및 권한을 체크하고 리다이렉트 해줍니다.

        model.addAttribute("formActionUrl", "/post/" + postId + "/c/modify/" + id);

        Post post = postService.getPostById(postId);
        List<Comments> comments = commentsService.getCommentsByPostId(postId);
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        model.addAttribute("updateComment", updateComment);
        return "post/post_detail";

    }


    @PostMapping("/post/{postId}/c/modify/{id}")
    public String ModifyComment(@PathVariable long id, @PathVariable long postId, @ModelAttribute Comments comment
            , RedirectAttributes redirectAttributes,@Valid CommentForm commentForm, BindingResult result) {
        log.info("/post/c/modify/{id} 포스트 요청이 들어왔습니다.", id);
        Comments Comment = commentsService.getCommentById(id);
        if (Comment == null) {
            log.error("댓글이 이미 삭제 되었습니다 {}접근 postid:{}" + id, postId);
            redirectAttributes.addFlashAttribute("errorMessage", "댓글이 이미 삭제되었습니다.");
            return "redirect:/post/" + postId;
        }

        String errorResult = validateCheck(result, commentForm, redirectAttributes, postId);
        if (errorResult != null) {
            return errorResult;
        }

        Comment.setContent(comment.getContent());
        commentsService.updateComments(comment.getId(), comment);
        return "redirect:/post/" + comment.getPostId();
    }

    /**
     *
     * @param principal 유저권한
     * @param comment 댓글
     * @param postId 게시글 아이디
     * @param redirectAttributes 에러메세지반환
     * @param errorMessage 댓글 { } 권한이 없습니다.
     * @return null
     *
     * 작성된 게시글과 유저의권한을 확인합니다.
     * principal 이 널인지 확인하여 로그인 상태를 확인합니다.
     *
     */
//    private String checkUserName(Principal principal, Comments comment, long postId, RedirectAttributes redirectAttributes,
//                                 String errorMessage) {
//        if (principal == null) {
//            redirectAttributes.addFlashAttribute("errorMessage", "댓글 "+errorMessage+"권한이 없습니다.1");
//            return "redirect:/post/" + postId;
//        }else if (!comment.getUserInfo().getUsername().equals(principal.getName())){
//            redirectAttributes.addFlashAttribute("errorMessage", "댓글 "+errorMessage+"권한이 없습니다.2");
//            return "redirect:/post/" + postId;
//        }
//        return null;
//    }

    public String checkAuthorAccess(Comments comment,Principal principal,RedirectAttributes redirectAttributes,
                                    String errorMessage,long postId ) {
        if (principal == null) { //객체 검증
            log.info("checkPostPermissionAndRedirect()실행됨\n인증되지 않은 사용자에 의한 시도.\n요청된 댓글 작성자: {}\n현재 로그인상태 : {}", comment.getUserInfo().getUsername(), !(principal == null));

            redirectAttributes.addFlashAttribute("errorMessage", "댓글"+errorMessage +"권한이 없습니다.1");
            return "redirect:/post/" + postId;
            // 어드민권한 체크
        } else if ((SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")))) {
            return null;
        }
        //작성자와 현재 접속한 유저 이름 체크
        else if (!comment.getUserInfo().getUsername().equals(principal.getName())) {
            log.info("checkPostPermissionAndRedirect()메소드 실행됨\n요청된 게시글 작성자:{}\n현재 로그인한 사용자:{}", comment.getUserInfo().getUsername(), principal.getName());
            redirectAttributes.addFlashAttribute("errorMessage", "댓글"+errorMessage +"권한이 없습니다.2");
            return "redirect:/post/" + postId;
        }
        return null;
    }




    /**
     *
     * @param bindingResult
     * @param commentForm
     * @param redirectAttributes 리다이렉트 객체 전달을 위함
     * @param postId
     * @return null;
     *
     * 원래 본인의 게시글로 리다이렉트 합니다.
     * 유효성 검사
     */
    private String validateCheck(BindingResult bindingResult, CommentForm commentForm, RedirectAttributes redirectAttributes, long postId) {
        if (bindingResult.hasErrors()) {
            // 폼 검증 실패 시 에러 메시지 추가
            redirectAttributes.addFlashAttribute("commentForm", commentForm);
            redirectAttributes.addFlashAttribute("errors", bindingResult.getAllErrors());

            List<ObjectError> errors = bindingResult.getAllErrors();
            for (ObjectError error : errors) {
                log.info("댓글 작성실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n실패이유: {}", error.getDefaultMessage());
                redirectAttributes.addFlashAttribute("updateComment", commentForm);
                return "redirect:/post/" + postId; // 에러 발생 시 돌아갈 페이지
            }
        }
        return null;
    }


}