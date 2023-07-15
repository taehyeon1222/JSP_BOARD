package com.nth.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserInfo {

    private Long id;
    private String username;
    private String password;
    private String createdDate;
}
/*
    CREATE TABLE USERINFO(
        id NUMBER(10) PRIMARY KEY,
    username VARCHAR2(50) NOT NULL,
    password VARCHAR2(100) NOT NULL,
    created_at DATE DEFAULT SYSDATE
);
*/
