package com.fzu.inventory_assistant.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fzu.inventory_assistant.pojo.Goods;
import com.fzu.inventory_assistant.service.GoodsService;
import com.fzu.inventory_assistant.utils.R;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Map;
//import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    GoodsService GS;

    @Autowired
    ObjectMapper mapper;
    @PostMapping("")
    public R addGoods(@RequestParam("goods") String goodsStr, @RequestParam("file") MultipartFile file) throws IOException {
        Goods goods= mapper.readValue(goodsStr,Goods.class);
        GS.addGoods(goods,file);
        return R.ok("添加物品成功");
    }

    @GetMapping("/rooms")
    public R getRooms(@RequestParam Integer userId){
        return R.ok("返回房间成功").put("data",GS.getRooms(userId));
    }
    @DeleteMapping("")
    public R deleteGoods(@RequestParam("id") Integer id){
        GS.deleteGoods(id);
        return R.ok("物品删除成功");
    }
}
