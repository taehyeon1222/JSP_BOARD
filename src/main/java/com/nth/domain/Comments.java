package com.nth.domain;

import lombok.Getter;
import lombok.Setter;


@Getter
@Setter
public class Comments {
    private Long id;
    private String content;
    private Long postId;
    private Long userId;
    private String createdDate;
    private UserInfo userInfo;
    private String title;
    private int likeCount;


    /* 오라클 작성 테이블 쿼리
    CREATE TABLE COMMENTS (
  id NUMBER PRIMARY KEY,
  content VARCHAR2(1000),
  post_id NUMBER,
  CONSTRAINT fk_comment_post
    FOREIGN KEY (post_id)
    REFERENCES post(id)
    ON DELETE CASCADE //삭제시 같이 삭제하도록
);
     */
}
