package com.nth.dto;

import com.nth.domain.UserInfo;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

//게시글데이터이동
@Getter
@Setter
public class PostForm {

    @NotEmpty(message = "제목은 필수 항목입니다.")
    @Size(max = 30, message = "제목수가 초과하였습니다.")
    private String title;

    @NotEmpty(message = "내용은 필수 항목입니다.")
    @Size(max = 500, message = "게시글작성수가 초과하였습니다.")
    private String content;

    @Pattern(regexp = "^(공지|자유|질문|건의)$", message = "올바른 카테고리를 선택해주세요.")
    private String category;

}
