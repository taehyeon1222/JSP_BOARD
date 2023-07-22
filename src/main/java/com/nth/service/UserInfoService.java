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
import org.springframework.transaction.annotation.Transactional;

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
            throw new RuntimeException("유저정보가 없습니다.");
        }
    }

    /**
     *
     * @param id
     * @return id 값으로 유저정보 검색
     *
     */
    public UserInfo getUserInfoById(Long id){
        log.info("getUserInfoById({})가 실행되었습니다.",id);
        UserInfo userInfo = userInfoMapper.getUserInfoById(id);
        if(userInfo == null){
            log.info("getUserInfoById({})에서 유저 검색을 실패했습니다.",id);
        }
        log.info("user검색 결과: {} 검색에 성공했습니다.",userInfo.getUsername());
        return userInfo;
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
            throw new Exception("이미 등록된 사용자 입니다.");
        }
    }


    /**
     *
     * @param username
     * @param currentPassword
     * @param newPassword
     * @throws Exception
     * 유저 비밀번호 변경
     */
    public void changePassword(String username, String currentPassword, String newPassword) throws Exception {
        log.info("changePassword()가 실행되었습니다.");
        // 현재 사용자 정보 검색
        UserInfo user = findByUsername(username);
        log.info("{}의 비밀번호 변경을 시도",user.getUsername());
        if (user == null) {
            throw new Exception("유저가 존재하지 않습니다.");
        }
        // 현재 비밀번호 확인
        if (!passwordEncoder.matches(currentPassword, user.getPassword())) {
            throw new Exception("현재 비밀번호가 일치하지 않습니다.");
        }
        // 새 비밀번호 암호화 및 업데이트
        String encryptedNewPassword = passwordEncoder.encode(newPassword);
        user.setPassword(encryptedNewPassword);
        userInfoMapper.updatePassword(user.getPassword(),user.getId());
        log.info("비밀번호가 변경되었습니다..");
    }


    /**
     * id로 유저 삭제
     */
    @Transactional
    public void deleteUserinfo(Long id){
        log.info("deleteUserinfo({})가 실행되었습니다.", id);
        UserInfo user = getUserInfoById(id);
        //사용자가 존재하는지 확인
        if(user==null){
            log.info("유저가 없습니다.");
            return;
        }
        userInfoMapper.deleteUserinfo(id);
        log.info("유저삭제완료");
        //사용자가 성공적으로 삭제되었는지 확인
//        UserInfo deletedUser = getUserInfoById(id);
//        if(deletedUser == null){
//            log.info("유저가 정상적으로 삭제되었습니다.");
//        } else {
//            log.info("유저가 삭제되지 않았습니다.");
//        }
    }



}
