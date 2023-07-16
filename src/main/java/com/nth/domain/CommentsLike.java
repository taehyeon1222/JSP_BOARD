package com.nth.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentsLike {

    Long userId;

    Long commentId;

    /*
    CREATE TABLE comment_Likes (
            user_id NUMBER,
            comment_id NUMBER,
            PRIMARY KEY (user_id,comment_id),
    FOREIGN KEY (user_id) REFERENCES userinfo(id) ON DELETE CASCADE,
    FOREIGN KEY (comment_id) REFERENCES comments(id) ON DELETE CASCADE);

     */
}
