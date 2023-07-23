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

    int getPostCountByUserName(String userId);


    List<Post> searchPostList(Map<String, Object> params); //검색

    List<Post> searchPostUsernameList(Map<String, Object> params); //아이디 검색

    List<Post> searchPostUsernameCategoryList(Map<String, Object> params);
    void increaseViewCount(Long id); //조회수


    /**
     *
     * @param params
     * @return
     * 카테고리+제목 이름으로 int 반환
     */
    int getPostCountByTitleAndCategory(Map<String, String> params);

    /**
     * @param params
     * @return
     * 카테고리 + 아이디로 int 반환
     */
    int getPostCountByUserNameAndCategory(Map<String, String> params);
}


