package com.fzu.inventory_assistant.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fzu.inventory_assistant.pojo.User;
import com.fzu.inventory_assistant.pojo.UserParam;
import com.fzu.inventory_assistant.service.UserService;
import com.fzu.inventory_assistant.utils.R;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.Map;

@RequestMapping("/user")
@RestController
public class UserController {
    @Resource
    UserService US;
    @PostMapping("/login")
    public R login(@RequestBody @Validated UserParam userParam,
                   @RequestHeader(value = "token",required = false) String token,
                   @RequestHeader() Map<String,String> map) throws JsonProcessingException {
//        map.forEach((key,value)->{
//            System.out.println(String.format("%s   =   %s",key,value));
//        });


        User user =US.login(userParam,token);
//        System.out.println(token);
        return R.ok("登录成功").put("user",user).put("token",user.getUserAccount());
    }

    @PostMapping("/register")
    public R register(@RequestBody User user){
        System.out.println(user);
        US.register(user);
        return R.ok("注册成功");
    }
}
