package com.nth.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserPasswordModify {

    @NotEmpty(message = "비밀번호는 필수 항목입니다.")
    @Pattern(regexp = "^[^\\s]+$", message = "공백을 포함하지 않은 값을 입력해주세요.")
    @Size(min = 4, max = 12, message = "비밀번호는 4글자 이상  12글자 이하로 입력해주세요")
    private String password;

    @NotEmpty(message = "비밀번호는 필수 항목입니다.")
    @Pattern(regexp = "^[^\\s]+$", message = "공백을 포함하지 않은 값을 입력해주세요.")
    @Size(min = 4, max = 12, message = "비밀번호는 4글자 이상  12글자 이하로 입력해주세요")
    private String newPassword;
}
