package com.nth.user;

import com.nth.domain.UserInfo;
import com.nth.mapper.UserInfoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class UserSecurityService implements UserDetailsService {

    private final UserInfoMapper userInfoMapper;

        @Override
        public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
            // username을 통해 사용자 정보를 조회합니다.
            Optional<UserInfo> _siteUser = this.userInfoMapper.findByUsername(username);

            // 조회된 사용자 정보가 없다면, UsernameNotFoundException을 발생시킵니다.
            if (_siteUser.isEmpty()) {
                throw new UsernameNotFoundException("사용자를 찾을 수 없습니다.");
            }

            // 조회된 사용자 정보를 가져옵니다.
            UserInfo siteUser = _siteUser.get();

            // 사용자에게 부여될 권한 목록을 생성합니다.
            List<GrantedAuthority> authorities = new ArrayList<>();

            // 사용자의 username이 'admin'인 경우, ADMIN 권한을 부여합니다.
            if ("admin".equals(username)) {
                authorities.add(new SimpleGrantedAuthority(UserRole.ADMIN.getValue()));
            } else { // 그 외의 경우, USER 권한을 부여합니다.
                authorities.add(new SimpleGrantedAuthority(UserRole.USER.getValue()));
            }

            // User 객체를 생성하여 반환합니다. 이 객체에는 username, password, 권한 목록이 포함됩니다.
            return new User(siteUser.getUsername(), siteUser.getPassword(), authorities);
        }

    }

