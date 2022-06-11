package com.fzu.inventory_assistant.service;

import com.fzu.inventory_assistant.pojo.Goods;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface GoodsService {
    Map<String,List<Goods>> getRooms(Integer ownerId);
    Integer addGoods(Goods goods, MultipartFile file) throws IOException;
    Integer deleteGoods(Integer id);
}
