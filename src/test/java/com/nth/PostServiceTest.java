package com.nth;

import com.nth.domain.Post;
import com.nth.mapper.PostMapper;
import com.nth.service.PostService;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class PostServiceTest {


    //단위테스트

//    @Test
//    public void testGetAllPosts() {
//        // Mock 객체 생성
//        PostMapper postMapper = Mockito.mock(PostMapper.class);
//
//        // Mock 객체에 원하는 동작 설정
//        Post post1 = new Post();
//        post1.setId(1L);
//        post1.setTitle("Title 1");
//        post1.setContent("Content 1");
//
//        Post post2 = new Post();
//        post2.setId(2L);
//        post2.setTitle("Title 2");
//        post2.setContent("Content 2");
//
//        List<Post> expectedPosts = Arrays.asList(post1, post2);
//        Mockito.when(postMapper.getAllPosts()).thenReturn(expectedPosts);
//
//        // 테스트 대상 객체 생성
//        PostService postService = new PostService(postMapper);
//
//        // 테스트 실행
//        List<Post> actualPosts = postService.getAllPosts();
//
//        // 결과 검증
//        assertThat(actualPosts).isEqualTo(expectedPosts);
//        System.out.println("성공함");
//    }


}
