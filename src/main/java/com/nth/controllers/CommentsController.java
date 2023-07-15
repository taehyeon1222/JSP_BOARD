package com.nth.controllers;

import com.nth.domain.Comments;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.CommentForm;
import com.nth.dto.PostForm;
import com.nth.service.CommentsService;
import com.nth.service.PostService;
import com.nth.service.UserInfoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
        //model.addAttribute("action", "/comments");
        log.info("/comments 겟맵핑이 발생함");
        return "redirect:/post/" + postId;
    }

    //댓글 작성
    @PostMapping("/comments")
    public String createComment(Comments comment, @RequestParam("postId") Long postId
            , Principal principal, Model model, RedirectAttributes redirectAttributes,
                                @Valid CommentForm commentForm, BindingResult result) {
        if (principal == null) {
            log.info("/comments 요청됨\n" +
                    "해당요청에서 principal==null이 감지되었습니다.");
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/post/" + postId;
        }
        if (result.hasErrors()) {
            // 폼 검증 실패 시 에러 메시지 추가
            redirectAttributes.addFlashAttribute("commentForm", commentForm);
            redirectAttributes.addFlashAttribute("errors", result.getAllErrors());

            List<ObjectError> errors = result.getAllErrors();
            for (ObjectError error : errors) {     //사용자에게 다시 글을 보여줌
                log.info("댓글 작성실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n" +
                        "실패이유: {}" + error.getDefaultMessage());
                model.addAttribute("updateComment", commentForm);
                return "redirect:/post/" + postId; // 에러 발생 시 돌아갈 페이지
            }
        }
        //System.out.println("createComment()메소드 실행됨");

        comment.setPostId(postId);
        comment.setContent(commentForm.getContent());
        //model.addAttribute("action","/comments"); //에 추가
        UserInfo userInfo = userInfoService.findByUsername(principal.getName());
        commentsService.createComment(comment, userInfo);
        log.info("/comments 실행됨" +
                        "\n*******************************************\n" +
                        "게시글 ID: {}\n" +
                        "입력된 댓글: {}" +
                        "\n*******************************************"
                , postId, comment.getContent()); // 댓글작성확인 로그
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
        log.info("/post/Comment/delete/{} 삭제요청이 들어왔습니다" +
                "\n게시물id:{}" +
                "\n댓글id:{} 게시글작성자{}", id, postId, id,comment.getUserInfo().getUsername());//댓글삭제로그
        if (principal == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 권한이 없습니다.1");
            return "redirect:/post/" + postId;
        }else if (!comment.getUserInfo().getUsername().equals(principal.getName())){
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 삭제 권한이 없습니다.2");
            return "redirect:/post/" + postId;
        }

        // 댓글을 삭제합니다.
        commentsService.deleteComment(id);
        return "redirect:/post/" + postId;
    }





    @GetMapping("/post/{postId}/c/modify/{id}")
    public String ModifyComment(@PathVariable long id, @PathVariable long postId, Model model
            , RedirectAttributes redirectAttributes,Principal principal) {

        Comments updateComment = commentsService.getCommentById(id);
        log.info("/post/modify/{id} GET 수정요청이 들어왔습니다." +
                "\n게시물 id 값 {}" +
                "\n댓글id값:{}", postId, id);
        if (updateComment == null) {
            log.error("댓글이 삭제 되어 댓글을 수정 할 수 없습니다. {}" +
                    "접근 postid:{}" + id, postId);
            redirectAttributes.addFlashAttribute("errorMessage", "댓글이 이미 삭제되었습니다.");
            return "redirect:/post/" + postId;
        }
        if (principal == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 수정 권한이 없습니다.1");
            return "redirect:/post/" + postId;
        }else if (!updateComment.getUserInfo().getUsername().equals(principal.getName())){
            redirectAttributes.addFlashAttribute("errorMessage", "댓글 수정 권한이 없습니다.2");
            return "redirect:/post/" + postId;
        }

        //model.addAttribute("formActionUrl", "/comments"); //게시글의 댓글을 위해 추가함
        model.addAttribute("formActionUrl", "/post/" + postId + "/c/modify/" + id);

        Post post = postService.getPostById(postId);
        List<Comments> comments = commentsService.getCommentsByPostId(postId);
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        model.addAttribute("updateComment", updateComment);
        return "post_detail";
    }


    @PostMapping("/post/{postId}/c/modify/{id}")
    public String ModifyComment(@PathVariable long id, @PathVariable long postId, @ModelAttribute Comments comment
            , RedirectAttributes redirectAttributes,@Valid CommentForm commentForm, BindingResult result) {
        log.info("/post/c/modify/{id} 포스트 요청이 들어왔습니다.", id);
        Comments Comment = commentsService.getCommentById(id);
        if (Comment == null) {
            log.error("댓글이 이미 삭제 되었습니다 {}" +
                    "접근 postid:{}" + id, postId);
            redirectAttributes.addFlashAttribute("errorMessage", "댓글이 이미 삭제되었습니다.");
            return "redirect:/post/" + postId;
        }
        if (result.hasErrors()) {
            // 폼 검증 실패 시 에러 메시지 추가
            redirectAttributes.addFlashAttribute("commentForm", commentForm);
            redirectAttributes.addFlashAttribute("errors", result.getAllErrors());

            List<ObjectError> errors = result.getAllErrors();
            for (ObjectError error : errors) {     //사용자에게 다시 글을 보여줌
                log.info("댓글 작성실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n" +
                        "실패이유: {}" + error.getDefaultMessage());
                redirectAttributes.addFlashAttribute("updateComment", commentForm);
                return "redirect:/post/" + postId; // 에러 발생 시 돌아갈 페이지
            }
        }
        ㅁ
        Comment.setContent(comment.getContent());
        commentsService.updateComments(comment.getId(), comment);
        return "redirect:/post/" + comment.getPostId();
    }



}