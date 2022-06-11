package com.fzu.inventory_assistant.mapper;

import com.fzu.inventory_assistant.pojo.Goods;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Mapper
@Repository
public interface GoodsMapper {
    Goods getGoodsById(Integer id);
    List<Goods> getGoodsByOwnerId(Integer ownerId);
    Integer addGoods(Goods goods);

    Integer deleteGoods(Integer id);
}
