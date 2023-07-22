package com.nth.exception;

import com.nth.service.CommentsService;
import jakarta.servlet.http.HttpServletRequest;
import org.apache.ibatis.javassist.NotFoundException;
import org.mybatis.spring.MyBatisSystemException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.HttpServerErrorException;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@ControllerAdvice
public class CustomExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(CustomExceptionHandler.class);


    //존재하지 않는 게시물 처리
    @ExceptionHandler(IllegalArgumentException.class)
    public String handleIllegalArgumentException(IllegalArgumentException ex, RedirectAttributes redirectAttributes) {
        log.info("\nhandleIllegalArgumentException()가  IllegalArgumentException 호출되었습니다.\n" +
                "에러내용:{}", ex.getMessage());
        redirectAttributes.addFlashAttribute("errorMessage", "이미 삭제 되었거나, 없는 게시물입니다.");
        return "redirect:/post";
    }

    //@ControllerAdvice 모든 컨트롤러에서 예외처리 어노테이션

    // 존재하지 않는 상세글 페이지 처리
    @ExceptionHandler(MyBatisSystemException.class)
    public String handleMyBatisSystemException(MyBatisSystemException ex, RedirectAttributes redirectAttributes) {
        log.info("\nhandleMyBatisSystemException()가  MyBatisSystemException.class 호출되었습니다.\n" +
                "에러내용:{}", ex.getMessage());
        redirectAttributes.addFlashAttribute("errorMessage", "이미 삭제 되었거나, 없는 게시물입니다.");
        return "redirect:/post";
    }


}










