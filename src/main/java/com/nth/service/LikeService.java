package com.nth.service;

import com.nth.domain.Like;
import com.nth.mapper.LikeMapper;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.MyBatisSystemException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class LikeService{

    private static final Logger log = LoggerFactory.getLogger(LikeService.class);

    private final LikeMapper likeMapper;

   // private final PostService postService;

    public void insertLike(Like like) {
        log.info("insertLike()가 실행되었습니다.");
        if(like.getPostId()==null){
          log.info("insertLike()가 null 입니다.{}",like.getPostId());
        }

        likeMapper.insertLike(like);
    }

    /**
     *
     * @param like
     * @return 좋아요 중복 체크
     */
    public Like duplicationLike(Like like) {
        log.info("duplicationLike()가 실행되었습니다." +
                "like.postid:{} like.userid:{}",like.getPostId(),like.getUserId());
        Like Likes = likeMapper.duplicationLike(like);

//        if(!postService.postIdcheck(like.getPostId())){
//            log.info("게시물이 없습니다.");
//            throw new MyBatisSystemException(new Throwable());
//        }

        if (Likes == null) {
            log.info("Likes가 null임.");
            //throw new MyBatisSystemException(new Throwable());
        }
        return Likes;
    }

    /**
     *
     * @param like
     * 삭제
     */

    public void deleteLike(Like like) {
        log.info("deleteLike()가 실행되었습니다.");
        likeMapper.deleteLike(like);

    }

    /**
     *
     * @param postId
     * @return postId 로 갯수를 나타냄
     */
    public Long countLike(long postId) {
        Long cnt =likeMapper.countLike(postId);
        return cnt;
    }

/********************************************************************************************/



}
