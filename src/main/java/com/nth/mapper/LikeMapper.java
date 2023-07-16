package com.nth.mapper;

import com.nth.domain.Like;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LikeMapper {

    void insertLike(Like like);

    Like duplicationLike(Like like);

    void deleteLike(Like like);

    Long countLike(long postId);
}
