package com.nth.dto;

import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserInfoForm {

    @Size(min = 1, max = 8, message = "사용자ID는 3글자 이상 25글자 이하로 입력해주세요.")
    @Pattern(regexp = "^[^\\s]+$", message = "공백을 포함하지 않은 값을 입력해주세요.")
    @NotEmpty(message = "사용자ID는 필수 항목입니다.")
    private String username;

    @NotEmpty(message = "비밀번호는 필수 항목입니다.")
    @Pattern(regexp = "^[^\\s]+$", message = "공백을 포함하지 않은 값을 입력해주세요.")
    @Size(min = 4, max = 12, message = "비밀번호는 4글자 이상 입력해주세요")
    private String password;

}
