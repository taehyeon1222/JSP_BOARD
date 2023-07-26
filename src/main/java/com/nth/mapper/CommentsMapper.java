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

    List<Comments> getCommentsByUserId(Map<String, Object> params); //유저 아이디로 댓글검색

    int getCommentsCountByUserName(String userName); // 유저 아이디로 검색후 댓글 수 반환

}
