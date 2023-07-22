package com.nth.mapper;

import com.nth.domain.Comments;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CommentsMapper {
    void insertComment(Comments comment);
    void updateComment(Comments comment);
    void deleteComment(Long id);


      Comments getCommentById(Long id);

    List<Comments> getCommentsByPostId(Long postId);

    List<Comments> getCommentsByUserId(Map<String, Object> params);

    int getCommentsCountByUserName(String userName);

}
