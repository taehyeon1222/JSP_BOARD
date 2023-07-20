package com.nth.mapper;

import com.nth.domain.Post;
import com.nth.service.Pagination;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

@Mapper()
public interface PostMapper {
    List<Post> getAllPosts();
    Post getPostById(Long id);
    void insertPost(Post post);
    void insertUserPost(Post post);
    void updatePost(Post post);
    void deletePost(Long id);


    List<Post> getPostList(Pagination pagination);
    int getPostCount(); // 게시글 총 개수를 반환하는 메소드

    int getPostCountByTitle(String search); //검색 게시글 총 개수를 반환하는 메소드

    int getPostCountByUserId(String userId);


    List<Post> searchPostList(Map<String, Object> params); //검색

    List<Post> searchPostIdList(Map<String, Object> params); //아이디 검색

    void increaseViewCount(Long id); //조회수


}


