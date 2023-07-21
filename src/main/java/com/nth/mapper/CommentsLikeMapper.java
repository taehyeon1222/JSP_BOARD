package com.nth.mapper;

import com.nth.domain.CommentsLike;
import com.nth.domain.Like;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface CommentsLikeMapper {

    void insertLike(CommentsLike commentsLike);

    CommentsLike duplicationLike(CommentsLike commentsLike);

    void deleteLike(CommentsLike commentsLike);

    Long countLike(long commentId);



}
