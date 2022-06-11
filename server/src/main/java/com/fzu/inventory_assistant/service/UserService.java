package com.fzu.inventory_assistant.service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fzu.inventory_assistant.pojo.User;
import com.fzu.inventory_assistant.pojo.UserParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public interface UserService {
    public User login(UserParam userParam, String token) throws JsonProcessingException;
    public boolean register(User user);
    public boolean destroy(User user);
}
