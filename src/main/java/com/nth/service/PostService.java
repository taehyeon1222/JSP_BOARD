package com.nth.service;

import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.PostForm;
import com.nth.mapper.PostMapper;
import lombok.RequiredArgsConstructor;
import org.apache.ibatis.javassist.NotFoundException;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.security.Principal;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PostService {

    private static final Logger log = LoggerFactory.getLogger(PostService.class);

    private final PostMapper postMapper;

    private final LikeService likeService;



    /**
     * 전체 게시글 가져오기
     * @return
     */
    public List<Post> getAllPosts() {
        return postMapper.getAllPosts();
    }

    /**
     * id로 가져오기
     * @param id
     * @return
     */
    public Post getPostById(Long id) {
        Post post = postMapper.getPostById(id);
        log.info("getPostById()가실행되었습니다.id:{}",id);
        if (id == null) {
            log.info("getPostById():ID 값이 없습니다.");
            throw new IllegalArgumentException("ID 값이 없습니다.");
        }
        if(post==null){
            log.info("getPostById():게시물을 불러올수가 없습니다.");
            throw new MyBatisSystemException(new Throwable("게시물 id " + id));
        }
        return post;


    }


    /**
     *
     * @param postForm 게시글폼
     * @param userInfo 유저정보
     * @return post객체를 반환합니다.
     */
    public Post createIdPost(PostForm postForm, UserInfo userInfo) {
        Post post = new Post();
        post.setTitle(postForm.getTitle());
        post.setContent(postForm.getContent());
        post.setUserInfo(userInfo);
        postMapper.insertUserPost(post);
        log.info("PostService\n" +
                        "\nCreateIdPost()실행됨" +
                        "\n입력된값" +
                        "\npostid:{}" +
                        "\n제목:[{}]" +
                        "\n내용:[{}]"+
                        "\n유저아이디:[{}]"
                ,post.getId()
                ,postForm.getTitle(),postForm.getContent()
                ,userInfo.getUsername() // 게시글 작성로그
        );
        return post;

    }


    //게시물 수정서비스
    public void updatePost(long id, Post post) {
        log.info("updatePost()가 실행되었습니다.\n 요청된 게시물 id: {}", id);
        Post Post = postMapper.getPostById(id);
        log.info("post == null에러 발생\n존재하지않는게시물");
        if (Post == null) {
            log.info("post == null에러 발생\n존재하지않는게시물");
            throw new RuntimeException("id가 널 입니다. id " + id);
        }
        Post.setTitle(post.getTitle());
        Post.setContent(post.getContent());
        postMapper.updatePost(Post);
        log.info("게시물이 수정 되었습니다.");
    }


    //게시물삭제서비스
    public void deletePost(long id) {
        log.info("deletePost()가 실행되었습니다.\n 요청된 게시물 id: {}", id);
        // 게시물 존재 여부 확인
        Post post = postMapper.getPostById(id);
        if (post == null) {
            log.info("post == null에러 발생\n존재하지않는게시물");
            throw new  RuntimeException("존재하지 않는 게시물입니다.");
        }
        String deletedTitle = post.getTitle(); // 삭제된 게시물의 제목
        log.info("삭제된 게시물 제목:{} ID:{}", deletedTitle);
        postMapper.deletePost(id);
        log.info("게시물이 성공적으로 삭제되었습니다.");
    }



    //게시물 카운트 페이징처리
    public int getPostCount() {
        return postMapper.getPostCount();
    }




    /**
    게시글 목록 불러오기 pagination을 값으로 넘겨 받아야함
     */
    public List<Post> getPostList(Pagination pagination) {
        int listCnt = postMapper.getPostCount();
        pagination.pageInfo(pagination.getPage(), pagination.getRange(), listCnt);
        List<Post> postList = postMapper.getPostList(pagination);

        for (Post post : postList) {
            Long likeCount = likeService.countLike(post.getId());
            post.setLikeCount(likeCount);
        }

        // 로깅을 통해 작성일 값 확인
//        for (Post post : postList) {
//
////            log.info("getPostList()메소드가 실행되었습니다.\n" +
////                            "********************불러온게시물********************"+
////                            "\nid값: {}"+
////                            "\n제목: {}"+
////                            "\n내용: {}"+
////                            "\n작성자: {}"+
////                            "\n********************불러온게시물********************",
////                    post.getId(), post.getTitle(), post.getContent(), post.getUserInfo().getUsername()
////            );
//
//
//        }

        return postList;
    }



    /**
     * 게시글 작성 테스트케이스에서 작성 이후 지우길
     * @param title
     * @param content
     */
    public void createPost(String title, String content) {
        Post post = new Post();
        post.setTitle(title);
        post.setContent(content);
        postMapper.insertPost(post);
    }






}