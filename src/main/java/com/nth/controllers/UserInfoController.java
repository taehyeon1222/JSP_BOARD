package com.nth.controllers;

import com.nth.domain.Comments;
import com.nth.domain.Post;
import com.nth.domain.UserInfo;
import com.nth.dto.PostForm;
import com.nth.dto.UserInfoForm;
import com.nth.dto.UserPasswordModify;
import com.nth.service.CommentsService;
import com.nth.service.Pagination;
import com.nth.service.PostService;
import com.nth.service.UserInfoService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class UserInfoController {
    private static final Logger log = LoggerFactory.getLogger(UserInfoController.class);

    private final UserInfoService userInfoService;
    private final PostService postService;

    private final CommentsService commentsService;

    //회원가입
    @GetMapping("/signup")
    public String signup(Principal principal) {

         return "signup_form";
     }

    //회원가입
    @PostMapping("/signup")
    public String signup(@Valid UserInfoForm userInfoForm, BindingResult bindingResult
    , Model model,RedirectAttributes redirectAttributes) {
        if (bindingResult.hasErrors()) {
            Map<String, String> errorMessages = new HashMap<>();

            for (FieldError error : bindingResult.getFieldErrors()) {
                errorMessages.put(error.getField(), error.getDefaultMessage());
            }

            model.addAttribute("errorMessages", errorMessages);

            for (Map.Entry<String, String> errorMessage : errorMessages.entrySet()) {
                log.info("유저가입실패\n유효성 검사 오류로 인해 등록하지 못했습니다.\n"+
                        "실패이유: Field - {}, Message - {}", errorMessage.getKey(), errorMessage.getValue());
            }
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
            log.info("유저가입성공");
            redirectAttributes.addFlashAttribute("successMessage", userInfoForm.getUsername() + "님, 회원가입에 성공하셨습니다.<br>이제 로그인 후 이용해주세요.");
            return "redirect:/login";
        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage()); // 사용자에게 에러 메시지 전달
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


    //유저정보
    @GetMapping("/userinfo")
    @PreAuthorize("isAuthenticated()")
    public String userinfo( @RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "1") int range,
                            Principal principal,Model model) {
        log.info("/userinfo 접근요청");
        if(principal ==null){
            log.info("userinfo()에서 principal이null");
            return "redirect:/login";
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username); //사용자 정보
        int listCount;
        listCount = postService.getPostCountByUserId(username);
        Pagination pagination = new Pagination();
        pagination.pageInfo(page, range, listCount);
        //  pagination.pageconfig(5,5);
         // pagination.setTotalCount(listCount);
        List<Comments> commentsList = commentsService.getCommentsByUserId(username, pagination);
        List<Post> postList = postService.searchPostUsernameList(username, pagination);
        model.addAttribute("commentsList",commentsList);
        model.addAttribute("postList",postList); // 게시글 객체를 뷰에 전달
        model.addAttribute("pagination", pagination); //페이징 정보를 객체에 전달
        model.addAttribute("user", user); // 유저 객체를 뷰에 전달
        return "userinfo";
    }

    //게시글확인
    @GetMapping("/userinfo/post")
    @PreAuthorize("isAuthenticated()")
    public String userinfoPost( @RequestParam(defaultValue = "1") int page,
                            @RequestParam(defaultValue = "1") int range,
                            Principal principal,Model model) {
        log.info("/userinfo/post 접근요청");
        if(principal ==null){
            log.info("userinfo()에서 principal이null");
            return "redirect:/login";
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username); //사용자 정보
        int listCount;
        listCount = postService.getPostCountByUserId(username);
        Pagination pagination = new Pagination();
        pagination.pageInfo(page, range, listCount);
        //  pagination.pageconfig(5,5);
        // pagination.setTotalCount(listCount);
        //List<Comments> commentsList = commentsService.getCommentsByUserId(username, pagination);
        List<Post> postList = postService.searchPostUsernameList(username, pagination);
        //model.addAttribute("commentsList",commentsList);
        model.addAttribute("postList",postList); // 게시글 객체를 뷰에 전달
        model.addAttribute("pagination", pagination); //페이징 정보를 객체에 전달
        model.addAttribute("user", user); // 유저 객체를 뷰에 전달
        return "userInfoPost";
    }
    //댓글보기
    @GetMapping("/userinfo/comment")
    @PreAuthorize("isAuthenticated()")
    public String userinfoComment( @RequestParam(defaultValue = "1") int page,
                                @RequestParam(defaultValue = "1") int range,
                                Principal principal,Model model) {
        log.info("/userinfo/comment 접근요청");
        if(principal ==null){
            log.info("userinfo()에서 principal이null");
            return "redirect:/login";
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username); //사용자 정보
        int listCount;
        listCount = commentsService.getCommentsCountByUserName(username);
        Pagination pagination = new Pagination();
        pagination.pageInfo(page, range, listCount);
        // pagination.pageconfig(5,5);

         pagination.setTotalCount(listCount);
        List<Comments> commentsList = commentsService.getCommentsByUserId(username, pagination);
        //List<Post> postList = postService.searchPostUsernameList(username, pagination);
        model.addAttribute("commentsList",commentsList);
        //model.addAttribute("postList",postList); // 게시글 객체를 뷰에 전달
        model.addAttribute("pagination", pagination); //페이징 정보를 객체에 전달
        model.addAttribute("user", user); // 유저 객체를 뷰에 전달
        return "userInfoComment";
    }

    //비밀번호 변경
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/userinfo/modify")
    public String userModify(){
        log.info("/userinfo/modify 경로의 겟맵핑 실행됨");
        return "userModifyForm";
    }

    //비밀번호 변경
    @PreAuthorize("isAuthenticated()")
    @PostMapping("/userinfo/modify")
    public String userModify(@Valid UserPasswordModify userPasswordModify, BindingResult bindingResult, Principal principal, Model model,
                             RedirectAttributes redirectAttributes,HttpServletRequest request) {
        log.info("/userinfo/modify 경로의 포스트맵핑 실행됨");
        // 특정 오류가 있는지 확인
        if(principal ==null){
            redirectAttributes.addFlashAttribute("successMessage", "비정상적인 접근 감지. 로그인 후 이용 가능합니다.");
            return "redirect:/login";
        }
        if (bindingResult.hasErrors()) {
            log.error("userModify()에서 검증 오류 발생: {}", bindingResult.getAllErrors());
            return "userModifyForm";
        }
        try {
            userInfoService.changePassword(principal.getName(), userPasswordModify.getPassword(),userPasswordModify.getNewPassword());
        } catch (Exception e) {
            log.info(e.getMessage());
            model.addAttribute("errorMessage", e.getMessage());
            return "userModifyForm";
        }
        // 로그아웃 처리
        SecurityContextHolder.getContext().setAuthentication(null);  // 보안 컨텍스트 초기화
        request.getSession().invalidate();  // 세션 종료


        return "redirect:/";
    }

    //
    @GetMapping("/userinfo/delete")
    @PreAuthorize("isAuthenticated()")
    public String deleteUser(Principal principal, Model model,RedirectAttributes redirectAttributes, HttpServletRequest request) {
        log.info("/userinfo/delete실행됨");
        if(principal ==null){
            log.info("userinfo()에서 principal이null 발생함");
            redirectAttributes.addFlashAttribute("successMessage", "비정상적인 접근 감지. 로그인 후 이용 가능합니다.");
            return "redirect:/login";
        }
        String username = principal.getName(); // 사용자 이름 리턴
        UserInfo user = userInfoService.findByUsername(username);
        userInfoService.deleteUserinfo(user.getId());

        // 로그아웃 처리
        SecurityContextHolder.getContext().setAuthentication(null);  // 보안 컨텍스트 초기화
        request.getSession().invalidate();  // 세션 종료

        return "redirect:/";
    }



}
