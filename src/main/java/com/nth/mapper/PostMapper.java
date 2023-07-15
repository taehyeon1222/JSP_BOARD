package com.nth.mapper;

import com.nth.domain.Post;
import com.nth.service.Pagination;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

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

    }


