package com.nth.controllers;

import com.nth.dto.UserInfoForm;
import com.nth.service.UserInfoService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.security.Principal;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.List;

@Controller
@RequiredArgsConstructor
public class UserInfoController {
    private static final Logger log = LoggerFactory.getLogger(UserInfoController.class);
    private final UserInfoService userInfoService;

    //회원가입
    @GetMapping("/signup")
    public String signup(Principal principal) {

         return "signup_form";
     }

    //회원가입
    @PostMapping("/signup")
    public String signup(@Valid UserInfoForm userInfoForm, BindingResult bindingResult
    ,Model model) {
        if (bindingResult.hasErrors()) { //유저 폼 인증
            List<ObjectError> errors = bindingResult.getAllErrors();

            model.addAttribute("errors", bindingResult.getAllErrors()); //에러 출력

            for (ObjectError error : errors) {
                model.addAttribute("UserInfoForm",userInfoForm);
                log.info("유저가입실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n"+
                        "실패이유: {}" + error.getDefaultMessage());
            }// 유효성검사 실패로그

            return "signup_form";
        }

        log.info("@PostMapping(\"/signup\")" +
                "\n\n***************************************************************\n" +
                "검증\n입력된 아이디 와 비밀번호가 통과되었습니다."+
                "\n[입력된값]\n" +
                "userInfoForm의 아이디 값: [ {}] " +
                "\nuserInfoForm의 비밀번호 값: [ {} ]  " +
                "\n\n****************************************************************" +
                "\n\n",userInfoForm.getUsername(),userInfoForm.getPassword()); // 검증된 값 출력 로그

        // 검증을 통과한 경우, 회원가입 로직 실행
        try {
            userInfoService.createUser(userInfoForm);
            log.info("유저가입성공\n홈디렉토리로 이동합니다.");
            return "redirect:/";

        } catch (Exception e) { // 모든 에러
            e.printStackTrace();
            bindingResult.reject("signupFailed", e.getMessage());
            return "signup_form";
        }
    }



    //로그인
    @GetMapping("/login")
    public String login() {
        log.info("@GetMapping(\"/login\")실행됨");
        return "login";
    }




}
