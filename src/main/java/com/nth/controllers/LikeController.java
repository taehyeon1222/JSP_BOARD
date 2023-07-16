package com.nth.controllers;

import com.nth.domain.CommentsLike;
import com.nth.domain.Like;
import com.nth.domain.UserInfo;
import com.nth.service.CommentsLikeService;
import com.nth.service.LikeService;
import com.nth.service.UserInfoService;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class LikeController {
    private static final Logger log = LoggerFactory.getLogger(LikeController.class);

    private final LikeService likeService;

    private final UserInfoService userInfoService;

    private final CommentsLikeService commentsLikeService;



    //댓글
    @GetMapping("/post/{postId}/comment/{commentId}/like")
    public String insertCommentLike(@PathVariable long postId, @PathVariable long commentId, Principal principal, RedirectAttributes redirectAttributes){
        log.info("/comment/{}/like 가 호출되었습니다.",commentId);
        if (principal == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/comment/"+commentId;
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username); //사용자 정보 반환

        log.info("정상적인 접근 \n좋아요 =댓글:{},사용자id:{} 사용자이름:{}",commentId,user.getId(),user.getUsername());
        Long userId = user.getId();

        // CommentsLike 객체를 생성하고, 사용자 ID와 댓글 ID를 설정합니다.
        CommentsLike commentsLike = new CommentsLike();
        commentsLike.setUserId(userId);
        commentsLike.setCommentId(commentId);

        // CommentLike 서비스를 사용해 사용자가 이미 좋아요를 눌렀는지 확인합니다.
        CommentsLike resultLike = commentsLikeService.duplicationLike(commentsLike);

        if (resultLike != null) {
            commentsLikeService.deleteLike(commentsLike);
            Long count = commentsLikeService.countLike(commentId);
            log.info("좋아요를 취소했습니다.현재 좋아요:{}",count);
            log.info("resultLike={}",resultLike.getUserId());
            return "redirect:/comment/"+commentId;
        }

        if(resultLike == null){
            // CommentLike 서비스를 사용해 Like 정보를 DB에 저장합니다.
            commentsLikeService.insertLike(commentsLike);
            Long count = commentsLikeService.countLike(commentId);
            log.info("좋아요를 완료했습니다..현재 좋아요:{}",count);
        }

        return "redirect:/comment/"+commentId;
    }





    //게시글
    @GetMapping("/post/{postId}/like{id}")
    public String insertLike(@PathVariable long id, @PathVariable long postId, Principal principal, RedirectAttributes redirectAttributes){
        log.info("/post/{postId}/like{id}",postId,id);
        if (principal == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "로그인이 필요합니다.");
            return "redirect:/post/"+postId;
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username); //사용자 정보 반환

        log.info("정상적인 접근 \n좋아요 =게시물:{} 댓글:{},사용자id:{} 사용자이름:{}",postId,user.getId(),user.getUsername());
        Long userId = user.getId();
        // Like 객체를 생성하고, 사용자 ID와 포스트 ID를 설정합니다.
        Like like = new Like();
        like.setUserId(userId);
        like.setPostId(postId);

        // Like 서비스를 사용해 사용자가 이미 좋아요를 눌렀는지 확인합니다.
        Like resultLike = likeService.duplicationLike(like);

        // resultLike가 null이 아니면, 로그를 출력합니다.
        if (resultLike != null) {
            likeService.deleteLike(like);
            Long count = likeService.countLike(postId);
            log.info("좋아요를 취소했습니다.현재 좋아요:{}",count);
            log.info("resultLike={}",resultLike.getUserId());
            return "redirect:/post/"+postId;

        } if(resultLike == null){
            // Like 서비스를 사용해 Like 정보를 DB에 저장합니다.
            likeService.insertLike(like);
            Long count = likeService.countLike(postId);
            log.info("좋아요를 완료했습니다..현재 좋아요:{}",count);
        }

        return "redirect:/post/"+postId;
    }



}
