package com.nth.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Like {

    Long postId;

    Long userId;


    /**
     CREATE TABLE likes (
     user_id NUMBER,
     post_id NUMBER,
     PRIMARY KEY (user_id, post_id),
     FOREIGN KEY (user_id) REFERENCES userinfo(id) ON DELETE CASCADE,
     FOREIGN KEY (post_id) REFERENCES post(id) ON DELETE CASCADE
     );
     */
}
