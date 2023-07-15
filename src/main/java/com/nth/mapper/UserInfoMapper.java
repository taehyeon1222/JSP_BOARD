package com.nth.mapper;

import com.nth.domain.UserInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.Optional;

@Mapper()
public interface UserInfoMapper {

    UserInfo getUserInfoById(Long id);

    /**
     * 유저아이디 검색.
     * @param username
     * @return
     */
    Optional<UserInfo> findByUsername(String username);


    void insertUserInfo(UserInfo userInfo);
}
