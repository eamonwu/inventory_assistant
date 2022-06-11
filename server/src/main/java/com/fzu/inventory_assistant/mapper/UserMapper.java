package com.fzu.inventory_assistant.mapper;

import com.fzu.inventory_assistant.pojo.User;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface UserMapper {
    User getUserById(Integer id);
    User getUserByAccount(String account);
    User getUserByEmail(String email);
    Integer addUser(User user);
}
