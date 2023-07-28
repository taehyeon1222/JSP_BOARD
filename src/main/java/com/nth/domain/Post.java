package com.nth.domain;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Date;

@Getter
@Setter
public class Post {
    private Long id;
    private String title;
    private String content;
    private Date createdDate;
    private Long userId;  // 추가: USER_ID 컬럼과 매핑되는 필드
    private UserInfo userInfo;
    private Long likeCount; //추천수
    private Long views;
    private String category;
}
