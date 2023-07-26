package com.nth.service;

import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.PostForm;
import com.nth.mapper.PostMapper;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class PostService {

    private static final Logger log = LoggerFactory.getLogger(PostService.class);

    private final PostMapper postMapper;



    /******************************게시글 조회 ************************/

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
     * 게시글 을 조회합니다.
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
        //increaseViewCount(id);
        return post;
    }
    /**
     * @param postId
     * @return 게시물 존재 여부 체크
     */
    public boolean postIdCheck(Long postId) {
        log.info("postIdcheck가 실행되었습니다.{},의 게시물의 존재여부 : ",postId);
        Post post = postMapper.getPostById(postId);
        log.info("게시물의 존재여부 : ",post != null);
        return post != null;
    }


    /******************************게시글 작성************************/
    /**
     *
     * @param postForm 게시글폼
     * @param userInfo 유저정보
     * @return post객체를 반환합니다.
     */
    public Post createIdPost(PostForm postForm, UserInfo userInfo) {
        Post post = new Post();
        checkAdminCategory(postForm); //유저가 선택한 폼에서 카테고리 확인 및 관리자 권한체크

        post.setTitle(postForm.getTitle());
        post.setContent(postForm.getContent());
        post.setCategory(postForm.getCategory()); // 카테고리 추가
        post.setUserInfo(userInfo);
        postMapper.insertUserPost(post);
        log.info("PostService\n" +
                        "\nCreateIdPost()실행됨" +
                        "\n입력된값" +
                        "\npostid:{}" +
                        "\n제목:[{}]" +
                        "\n내용:[{}]"+
                        "\n카테고리:[{}]"+
                        "\n유저아이디:[{}]"
                ,post.getId()
                ,postForm.getTitle(),postForm.getContent(),postForm.getCategory()
                ,userInfo.getUsername() // 게시글 작성로그
        );
        return post;
    }
    //게시물 수정서비스
    public void updatePost(long id, PostForm postForm) {
        log.info("updatePost()가 실행되었습니다.\n 요청된 게시물 id: {}", id);

        checkAdminCategory(postForm); //유저가 선택한 폼에서 카테고리 확인 및 관리자 권한체크

        Post updatePost = postMapper.getPostById(id);
        if (updatePost == null) {
            log.info("post == null에러 발생\n존재하지않는게시물");
            throw new RuntimeException("id가 널 입니다. id " + id);
        }
        updatePost.setTitle(postForm.getTitle());
        updatePost.setContent(postForm.getContent());
        updatePost.setCategory(postForm.getCategory()); // 카테고리 추가
        postMapper.updatePost(updatePost);
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

    /******************************게시글 페이징 ************************/

    /**
     * @param kw 키워드
     * @param pagination 페이징설정값
     * @param category 카테고리
     * @return 카테고리 와 키워드(제목+내용)으로 게시글 검색
     */
    public List<Post> searchPostTitleCategoryList(String kw,Pagination pagination,String category) {
        log.info("searchPostTitleCategoryList()가 실행됨\n입력된검색어:{}",kw);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("title", kw);
        paramMap.put("category", category); // category 파라미터 추가
        paramMap.put("startList", pagination.getStartList());
        paramMap.put("listSize", pagination.getListSize());
        return postMapper.searchPostTitleCategoryList(paramMap);
    }

    /**
     * @param username 키워드 및 유저이름
     * @param pagination 페이징 설정값.
     * @return 유저이름으로 검색 (카테고리를 무시) 유저정보에서 사용중
     */
    public List<Post> searchPostUsernameList(String username, Pagination pagination) {
        log.info("searchPostIdList()가 실행됨\n입력된검색어:{}",username);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("username", username);
        paramMap.put("startList", pagination.getStartList());
        paramMap.put("listSize", pagination.getListSize());
        return postMapper.searchPostUsernameList(paramMap);
    }

    /**
     * @param username 유저이름
     * @param pagination 페이징설정값
     * @param category 카테고리
     * @return 유저이름으로 검색 + 카테고리 검색
     */
    public List<Post> searchPostUsernameCategoryList(String username, Pagination pagination,String category) {
        log.info("searchPostIdList()가 실행됨\n입력된검색어:{}",username);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("username", username);
        paramMap.put("category", category); // category 파라미터 추가
        paramMap.put("startList", pagination.getStartList());
        paramMap.put("listSize", pagination.getListSize());
        return postMapper.searchPostUsernameCategoryList(paramMap);
    }


    /**
     * @param keyword
     * @return 총 게시글 수 를 키워드로 반환(카테고리를 무시함)
     */
    public int getPostCountByTitle(String keyword) {
        int result = postMapper.getPostCountByTitle(keyword);
        log.info("getPostCountByTitle({})가 실행되었습니다.\n 검색된 게시글 수의 반환값:{}",keyword,result);
        return result;
    }
    /**
     *
     * @param keyword
     * @param category
     * @return 키워드로 총 게시글수를 카테고리를 포함해서 반환
     */
    public int getPostCountByTitleAndCategory(String keyword, String category) {
        Map<String, String> params = new HashMap<>();
        params.put("title", keyword);
        params.put("category", category);

        int result = postMapper.getPostCountByTitleAndCategory(params);
        log.info("getPostCountByTitleAndCategory({},{})가 실행되었습니다.\n 검색된 게시글 수의 반환값:{}",keyword, category, result);
        return result;
    }

    /**
     * @param userName
     * @return
     * 유저이름으로 값을 받아서 전체 게시글 수 를 반환해줍니다.(카테고리를 무시함)
     */
    public int getPostCountByUserName(String userName) {
        int result = postMapper.getPostCountByUserName(userName);
        log.info("getPostCountByUserId({})가 실행되었습니다.\n 검색된 게시글 수의 반환값:{}",userName,result);
        return result;
    }
    /**
     *
     * @param keyword
     * @param category
     * @return
     *  유저이름 + 카테고리로 총 게시글 수를 반환해줍니다.
     */
    //유저이름과 카테고리로 검색
    public int getPostCountByUserNameAndCategory(String keyword, String category) {
        Map<String, String> params = new HashMap<>();
        params.put("userName", keyword);
        params.put("category", category);
        int result = postMapper.getPostCountByUserNameAndCategory(params);
        log.info("getPostCountByTitleAndCategory({},{})가 실행되었습니다.\n 검색된 게시글 수의 반환값:{}",keyword, category, result);
        return result;
    }

    /******************************그 외  ************************/

    /**
     *
     * @param id
     * @return
     * post를 맵핑하고 조회수를 추가해줍니다.
     */
    public Post viewPost(Long id){
        log.info("viewPost({})가 실행되었습니다",id);
        Post post = postMapper.getPostById(id);
        increaseViewCount(id); //조회수반환
        return post;
    }
    /**
    조회수 추가
     */
    public void increaseViewCount(Long id) {
        log.info("increaseViewCount({})가 실행되었습니다.",id);
        postMapper.increaseViewCount(id);
    }

//    /**
//     * 게시글 작성 테스트케이스에서 작성 이후 지우길
//     * @param title
//     * @param content
//     */
//    public void createPost(String title, String content) {
//        Post post = new Post();
//        post.setTitle(title);
//        post.setContent(content);
//        postMapper.insertPost(post);
//    }

    /******************************유틸 메서드 ************************/


    /**
     *
     * @param postForm
     * 카테고리 접근권한체크
     */
    private void checkAdminCategory(PostForm postForm){
        if("공지사항".equals(postForm.getCategory()) &&
                (!SecurityContextHolder.getContext().getAuthentication().isAuthenticated() ||
                        !SecurityContextHolder.getContext().getAuthentication().getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")))){
            postForm.setCategory("자유");
        }
    }

//
//    private void checkAdminAndResetCategory(PostForm postForm) {
//        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
//        if ("공지사항".equals(postForm.getCategory()) &&
//                (!auth.isAuthenticated() || !auth.getAuthorities().contains(new SimpleGrantedAuthority("ROLE_ADMIN")))) {
//            postForm.setCategory("자유");
//        }
//    }



}