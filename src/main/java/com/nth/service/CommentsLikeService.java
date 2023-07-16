package com.nth.service;

import com.nth.domain.CommentsLike;
import com.nth.mapper.CommentsLikeMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CommentsLikeService {

    private static final Logger log = LoggerFactory.getLogger(CommentsLikeService.class); // 수정된 부분

    private final CommentsLikeMapper commentsLikeMapper;

    public void insertLike(CommentsLike commentsLike) {
        log.info("insertLike()가 실행되었습니다.");
        commentsLikeMapper.insertLike(commentsLike);
    }

    /**
     * @param like
     * @return 좋아요 중복 체크
     */
    public CommentsLike duplicationLike(CommentsLike like) {
        log.info("duplicationLike()가 실행되었습니다." +
                "like.commentid:{} like.userid:{}", like.getCommentId(), like.getUserId()); // 수정된 부분
        CommentsLike Likes = commentsLikeMapper.duplicationLike(like);
        if (Likes == null) {
            log.info("Likes가 null임");
        }
        return Likes;
    }

    /**
     * @param like 삭제
     */

    public void deleteLike(CommentsLike commentsLike) {
        log.info("deleteLike()가 실행되었습니다.");
        commentsLikeMapper.deleteLike(commentsLike);

    }

    /**
     * @param commentsId
     * @return commentsId 로 갯수를 나타냄
     */
    public Long countLike(long commentsId) {
        Long cnt = commentsLikeMapper.countLike(commentsId);
        return cnt;
    }

/********************************************************************************************/

}
