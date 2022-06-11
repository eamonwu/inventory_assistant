package com.fzu.inventory_assistant.service.impl;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fzu.inventory_assistant.mapper.UserMapper;
import com.fzu.inventory_assistant.pojo.User;
import com.fzu.inventory_assistant.pojo.UserParam;
import com.fzu.inventory_assistant.service.UserService;
import com.fzu.inventory_assistant.utils.BizException.BizErrorCodeEnum;
import com.fzu.inventory_assistant.utils.BizException.BizException;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Resource
    private UserMapper UM;
    @Resource
    private ObjectMapper mapper;

    @Override
    public User login(UserParam userParam, String token) throws JsonProcessingException {
        User user;
//        如果token不为null使用token登录
        if (token != null) {
//            System.out.println("token=====" + token);
            user = UM.getUserByAccount(token);
            if (user == null) {
                throw new BizException(BizErrorCodeEnum.UNAUTHORIZED);
            }
        } else {
            user = UM.getUserByAccount(userParam.getUserAccount());
            if (user == null) {
                System.out.println("用户不存在");
                throw new BizException(BizErrorCodeEnum.USER_NOT_EXIST);
            }
            if (!user.getUserPassword().equals(userParam.getUserPassword())) {
                throw new BizException(BizErrorCodeEnum.USER_PASSWORD_ERROR);
            }
        }
        user.setUserPassword("");
        return user;
    }

    @Override
    public boolean register(User user) {
        User hasUser = UM.getUserByAccount(user.getUserAccount());
        if (hasUser != null)
            throw new BizException(BizErrorCodeEnum.USER_ACCOUNT_EXIST);
        hasUser = UM.getUserByEmail(user.getUserEmail());
        if (hasUser != null)
            throw new BizException(BizErrorCodeEnum.USER_EMAIL_EXIST);
        user.setRegisterDate(LocalDateTime.now());
        UM.addUser(user);
        return true;
    }

    @Override
    public boolean destroy(User user) {
        return false;
    }
}
