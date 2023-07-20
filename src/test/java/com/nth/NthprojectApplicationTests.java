package com.nth;

import com.nth.domain.Comments;
import com.nth.domain.Like;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.mapper.CommentsMapper;
import com.nth.mapper.LikeMapper;
import com.nth.mapper.PostMapper;
import com.nth.service.CommentsService;
import com.nth.service.Pagination;
import com.nth.service.PostService;
import com.nth.service.UserInfoService;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

@SpringBootTest
@MapperScan("com.nth.mapper")
class NthprojectApplicationTests {

    private static final Logger log = LoggerFactory.getLogger(NthprojectApplicationTests.class);

    @Autowired
    private PostService postService;
    @Autowired
    CommentsService commentsService;
    @Autowired
    UserInfoService userInfoService;
    @Autowired
    CommentsMapper commentsMapper;

    @Autowired
    LikeMapper likeMapper;

    @Autowired
    private PostMapper postMapper;

    //게시글 생성
//    @Test
//    public void testCreatePost() {
//
//
//        // 테스트 데이터 준비
//
//        for(int i=0;i<10;i++){
//            String title = "제목"+i;
//            String content = "내용"+i;
//            postService.createPost(title, content);
//        }
//
//        String title = "제목";
//        String content = "내용";
//        postService.createPost(title, content);
//
//        // 테스트 결과 검증
////        Post post = postMapper.getAllPosts().get(0);
////        assertThat(post.getTitle()).isEqualTo(title);
////        assertThat(post.getContent()).isEqualTo(content);
//    }
//
//
//    //게시글 전체 삭제
//    @Test
//    public void testDeletPost() {
//        for(long i=0;i<1000;i++)
//        postMapper.deletePost(i);
//    }
//
//
//    //댓글 작성
//    @Test
//    public void testInsertComment() {
//        Comments comment = new Comments();
//        comment.setContent("안녕");
//        comment.setPostId(256L);
//        comment.setUserId(1L);
//
//        // userInfo 객체 설정
//        UserInfo userInfo = userInfoService.findByUsername("하이");
//        comment.setUserInfo(userInfo);
//
//        commentsMapper.insertComment(comment);
//
//        // 테스트 결과 확인
//        System.out.println("Inserted Comment ID: " + comment.getId());
//        Comments insertedComment = commentsMapper.getCommentById((long) comment.getId());
//        System.out.println("Inserted Comment: " + insertedComment);
//        System.out.println("입력된 내용: " + comment.getContent());
//        System.out.println("작성자: " + comment.getUserInfo().getUsername());
//    }
//
//
//    //댓글확인
//    @Test
//    public void testGetCommentById() {
//        // 댓글 ID
//        Long commentId = 7L;
//        Long postId = 221l;
//        // 댓글 조회
//        Comments comment = commentsService.getCommentById(commentId);
//
//        // 댓글이 올바르게 조회되었는지 확인
//        assertNotNull(comment);
//        assertEquals(commentId, comment.getId());
//
//        // 댓글 내용 출력
//        System.out.println("댓글 ID: " + comment.getId());
//        System.out.println("댓글 내용: " + comment.getContent());
//        System.out.println("게시글 ID: " + comment.getPostId());
//
//        // 게시글 ID로 댓글 목록 조회
//
//        List<Comments> commentsByPostId = commentsService.getCommentsByPostId(postId);
//        System.out.println("게시글 ID로 조회된 댓글 목록: " + commentsByPostId);
//
//    }

    //추천
    @Test
    public void testLike(){
        Like like = new Like();
        like.setPostId(353L);
        like.setUserId(13L);
        likeMapper.insertLike(like);
    }

    //추천삭제

    @Test
    public void testLike2(){
        Like like = new Like();
        like.setPostId(353L);
        like.setUserId(13L);
        likeMapper.deleteLike(like);
    }

    //추천수확인
    @Test
    public void testLike3(){
        Long cont = likeMapper.countLike(362l);
        System.out.println(cont);
    }

    //조회
    @Test
    public void testLike4() {
        Like like = new Like();
        like.setUserId(13L);
        like.setPostId(353L);

        Like result = likeMapper.duplicationLike(like);

        if (result == null) {
            System.out.println("No match found");
        } else {
            System.out.println("Match found: UserId = " + result.getUserId() + ", PostId = " + result.getPostId());
        }

        assertNotNull(result);
    }

    @Test
    public void test4(){

        Post post = new Post();
        post = postMapper.getPostById(367l);
        postService.increaseViewCount(367L);
        assertEquals(1, post.getViews());
    }




}




