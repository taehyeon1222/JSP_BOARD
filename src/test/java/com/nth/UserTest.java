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

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

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

    @Test
    public void testGetUserInfoById() {
        Long userId = 15L; //
        UserInfo userInfo = userInfoService.getUserInfoById(userId);
        assertNotNull(userInfo); // 사용자 정보가 null이 아닌지 검증
        assertEquals(userId, userInfo.getId()); // ID가 일치하는지 검증

        System.out.println(userInfo.getUsername());
        System.out.println(userInfo.getCreatedDate());
        System.out.println(userInfo.getPassword());
    }

    @Test
    public void testUserInfoUpdatePassword(){
        Long userId = 48L;
        UserInfo userInfo = userInfoService.getUserInfoById(userId);
        assertNotNull(userInfo); // 사용자 정보가 null이 아닌지 검증
        assertEquals(userId, userInfo.getId()); // ID가 일치하는지 검증
        System.out.println(userInfo.getUsername());
        System.out.println(userInfo.getCreatedDate());
        System.out.println(userInfo.getPassword());
        userInfoMapper.updatePassword("7890",userId);
        UserInfo userInfo2 = userInfoService.getUserInfoById(userId);
        System.out.println(userInfo2.getUsername());
        System.out.println(userInfo2.getCreatedDate());
        System.out.println(userInfo2.getPassword());
    }


    @Test
    public void testUserInfoUpdatePassword2Service() throws Exception {

        userInfoService.changePassword("admin","1234","0000");
    }

    @Test
    public void testdeleteUserinfo(){
        Long Id = 50L;
        userInfoService.deleteUserinfo(Id);
    }

}
