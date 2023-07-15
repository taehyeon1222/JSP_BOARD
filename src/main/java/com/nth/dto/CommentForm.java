package com.nth.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommentForm {

    @NotEmpty(message = "내용은 필수 항목입니다.")
    @Size(max = 200, message = "댓글작성수가 초과하였습니다.")
    private String content;

}
