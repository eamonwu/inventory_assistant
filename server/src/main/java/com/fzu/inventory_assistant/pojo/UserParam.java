package com.fzu.inventory_assistant.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotNull;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class UserParam {
    @NotNull(message = "用户账户不能为空")
    public String userAccount;
    @NotNull(message = "用户密码不能为空")
    public String userPassword;
    public String token;
}
