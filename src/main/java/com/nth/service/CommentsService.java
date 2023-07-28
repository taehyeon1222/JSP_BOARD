package com.nth.service;

import com.nth.controllers.CommentsController;
import com.nth.domain.Comments;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.CommentForm;
import com.nth.mapper.CommentsMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentsService {
    private static final Logger log = LoggerFactory.getLogger(CommentsService.class);

    private final CommentsMapper commentsMapper;

    public CommentsService(CommentsMapper commentsMapper) {
        this.commentsMapper = commentsMapper;
    }


    /**
     *
     * @param commentId
     * @return 코멘트ID로 값을 받아서 댓글이 존재하는지 결과를 반환합니다.
     */
    public boolean commentIdcheck(Long commentId) {
        log.info("postIdcheck가 실행되었습니다.{},의 게시물의 존재여부 : ",commentId);
        Comments comments = commentsMapper.getCommentById(commentId);
        log.info("게시물의 존재여부 : ",comments != null);
        return comments != null;
    }

    /**
     * @param postId 연결할 게시글id값
     * @param comment 댓글정보
     * @param userInfo 유저정보
     * 댓글작성
     */
    public void createComment(long postId,CommentForm commentForm, UserInfo userInfo) {
        Comments comment = new Comments();
        comment.setPostId(postId); // 현재 postid를 넣어줌
        comment.setUserInfo(userInfo); // 유저의 정보를 저장함
        comment.setContent(commentForm.getContent());
        log.info("createComment()실행됨\n입력된값\n내용:[{}]\n유저아이디:[{}]",comment.getContent(),userInfo.getUsername());
        commentsMapper.insertComment(comment);
        log.info("댓글작성이 성공적으로 완료되었습니다.");
    }


    /**
     *
     * @param Id (postId)
     * @return 게시물 id값으로 댓글을 불러옵니다.
     */
    public List<Comments> getCommentsByPostId(Long Id) {
        log.info("getCommentsByPostId()가 실행됨\n불러온 게시물 id:{}",Id);
        return commentsMapper.getCommentsByPostId(Id);
    }
    /**
     * @param id 댓글id
     * @return
     * 댓글 id값으로 한개의 댓글 불러오기
     */
    public Comments getCommentById(Long id) {
        if (id == null) {
            throw new RuntimeException("해당 ID에 대한 코멘트를 찾을 수 없습니다: " + id);
        }
        log.info("getCommentById가 실행됨"+
                "\n넘어온 Id{} 실행결과- \n", id);
        return commentsMapper.getCommentById(id);
    }



    /**
     * @param id 댓글id
     * @param comments 댓글정보
     * 댓글 수정
     */
    public void updateComments(long id,CommentForm comments) {
        log.info("updateComments()가 실행되었습니다. id값: {}, comments값: {}", id, comments.getContent());
        Comments comment = commentsMapper.getCommentById(id);
        if (comment == null) {
            throw new RuntimeException("해당 ID에 대한 코멘트를 찾을 수 없습니다: " + id);
        }
        // 코멘트의 내용을 업데이트

        comment.setContent(comments.getContent());
        commentsMapper.updateComment(comment);
    }


    //댓글삭제
    public void deleteComment(long id){
        log.info("deleteComment()가실행됨\n불러온id값:{}",id);
        commentsMapper.deleteComment(id);
    }


    /**
     * @param username 유저이름
     * @param pagination 페이징설정
     * @return 유저이름으로 작성된 댓글을 불러옵니다.
     */
    public List<Comments> getCommentsByUserId(String userName, Pagination pagination){
        log.info("getCommentsByUserId()가 실행됨\n입력된검색어:{}",userName);
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("username", userName);
        paramMap.put("startList", pagination.getStartList());
        paramMap.put("listSize", pagination.getListSize());
        return commentsMapper.getCommentsByUserId(paramMap);
    }

    /**
     * @param userName
     * @return 유저이름으로 작성된 댓글 수를 반환
     */
    public int getCommentsCountByUserName(String userName){
        int result = commentsMapper.getCommentsCountByUserName(userName);
        log.info("getCommentsCountByUserName({})이 실행되었습니다.",result);
        return  result;
    }







}
