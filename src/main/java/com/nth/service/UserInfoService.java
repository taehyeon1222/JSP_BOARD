package com.nth.service;


import com.nth.domain.UserInfo;
import com.nth.dto.UserInfoForm;
import com.nth.mapper.UserInfoMapper;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserInfoService {

    private static final Logger log = LoggerFactory.getLogger(UserInfoService.class);

    private final UserInfoMapper userInfoMapper;
    private final PasswordEncoder passwordEncoder;


    public UserInfo findByUsername(String username) {
        Optional<UserInfo> user = userInfoMapper.findByUsername(username);
        if(user.isPresent()){
            return  user.get();
        } else {
            throw new RuntimeException("User not found");
        }
    }

    /**
     * 유저회원가입
     * @param userInfo
     * @throws Exception
     */
    public void createUser(UserInfoForm userInfo) throws Exception {
        // UserInfoForm 객체에서 필요한 정보 추출
        String username = userInfo.getUsername();
        String password = userInfo.getPassword();

        // 비밀번호 암호화
        String encryptedPassword = passwordEncoder.encode(password);

        log.info("UserInfoService.class 호출\n\n"+
                        "****************************************************************"+
                        "\ncreateUser(UserInfo userInfo) 유저가입 서비스 실행됨,\n\n" +
                        "넘어온 userInfoForm의 아이디: [ {} ]" +
                        "\n넘어온 userInfoForm의 비밀번호: [ {} ]" +
                        "\n암호화된 비밀번호: [ {} ] " +
                        "\n****************************************************************\n\n" // 서비스로그 (암호화)
                ,userInfo.getUsername(),userInfo.getPassword(),encryptedPassword);
        // UserInfo 객체 생성 및 값 설정
        UserInfo user = new UserInfo();
        user.setUsername(username);
        user.setPassword(encryptedPassword);
        // UserInfo 객체를 데이터베이스에 저장

        try {
            userInfoMapper.insertUserInfo(user);
        } catch (DataIntegrityViolationException e) {
            throw new Exception("이미 등록된 사용자입니다.");
        }
    }




}
