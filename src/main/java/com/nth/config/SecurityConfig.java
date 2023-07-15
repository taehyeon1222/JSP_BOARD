package com.nth.config;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfiguration;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


@Configuration
@EnableWebSecurity //모든 경로가 스프링시큐리티의 제어를 받음
@RequiredArgsConstructor
public class SecurityConfig  {


    @Bean // 스프링 빈으로 등록하라는 어노테이션. 이 메서드가 반환하는 객체가 스프링 빈으로 등록됩니다.
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception { // HttpSecurity 객체를 매개변수로 받는 filterChain 메서드 정의
        http.authorizeHttpRequests() // HTTP 요청에 대한 보안 설정을 시작
                .requestMatchers( // 요청 패턴에 대한 커스텀 보안 설정을 시작
                        new AntPathRequestMatcher("/**")) // 모든 경로('**')에 대한 요청을 처리하도록 AntPathRequestMatcher를 사용하여 설정
                .permitAll() // 모든 요청을 허용
                .and() // 보안 설정을 연결. 다음 설정으로 넘어감
                .csrf().disable() // CSRF 보호 기능을 비활성화
                .formLogin() // 폼 기반 로그인에 대한 설정을 시작
                .loginPage("/login") // 로그인 페이지의 경로를 "/user/login"으로 설정
                .defaultSuccessUrl("/")// 로그인 성공 후 리다이렉션할 기본 URL을 "/"로 설정
         .and()
         .logout()
         .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
         .logoutSuccessUrl("/")
        .invalidateHttpSession(true);

        return http.build(); // 위에서 설정한 내용에 따라 SecurityFilterChain 객체를 생성하고 반환
    }

    @Bean
    PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }





}
