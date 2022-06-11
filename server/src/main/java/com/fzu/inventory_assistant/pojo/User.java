package com.fzu.inventory_assistant.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;
import java.io.Serializable;
import java.time.LocalDateTime;



@Data
@AllArgsConstructor
@NoArgsConstructor
public class User implements Serializable {
    static interface login{};
    static interface register{};
    Integer id;

    @NotNull(message = "注册失败,账号不能为空")
    String userAccount;
    @NotNull(message = "注册失败,密码不能为空")
    String userPassword;
    @Email(message = "邮箱格式错误")
    String userEmail;
    LocalDateTime registerDate;
}
