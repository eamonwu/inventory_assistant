package com.fzu.inventory_assistant.service.impl;

import com.fzu.inventory_assistant.pojo.UserParam;
import com.fzu.inventory_assistant.service.GoodsService;
import com.fzu.inventory_assistant.service.UserService;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import static org.junit.jupiter.api.Assertions.*;

@RunWith(SpringRunner.class)
@SpringBootTest
class GoodsServiceImplTest {

    @Autowired
    GoodsService goodsService;

    @Test
    void login() {
//        UserParam userParam = new UserParam("21412", "flutter", null);
//        userService.login(userParam,null,null);
    }

    @Test
    void deleteTest() {
        System.out.println(goodsService.deleteGoods(1));
    }
}