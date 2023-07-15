package com.nth;

import com.nth.domain.UserInfo;
import com.nth.mapper.UserInfoMapper;
import com.nth.service.UserInfoService;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@SpringBootTest
@MapperScan("com.nth.mapper")
public class UserTest {

    @Autowired
    UserInfoService userInfoService;

    @Autowired
    UserInfoMapper userInfoMapper;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Test
    public void test1(){
        System.out.println("하이");
    }

    @Test
    public void createUserTest(){
        UserInfo user = new UserInfo();
        user.setId(3L);
        user.setUsername("테스트아이디3");
        user.setPassword("123456");
        String encryptedPassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encryptedPassword);
        userInfoMapper.insertUserInfo(user);

    }
}
