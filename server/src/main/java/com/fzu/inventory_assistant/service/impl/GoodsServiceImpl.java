package com.fzu.inventory_assistant.service.impl;

import com.fzu.inventory_assistant.mapper.GoodsMapper;
import com.fzu.inventory_assistant.pojo.Goods;
import com.fzu.inventory_assistant.service.GoodsService;
import com.fzu.inventory_assistant.utils.BizException.BizErrorCodeEnum;
import com.fzu.inventory_assistant.utils.BizException.BizException;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
public class GoodsServiceImpl implements GoodsService {
    @Resource
    GoodsMapper GM;

    @Override
    public Map<String, List<Goods>> getRooms(Integer ownerId) {
        Map<String, List<Goods>> rooms = new HashMap<>();
        rooms.put("未分类", new ArrayList<>());
        List<Goods> goods = GM.getGoodsByOwnerId(ownerId);
        for (Goods g : goods) {
            List<Goods> room = rooms.get(g.getGoodsGroup());
            if (room == null) {
                rooms.put(g.getGoodsGroup(), new ArrayList<>());
            }
            rooms.get(g.getGoodsGroup()).add(g);
        }
//        for (Map.Entry<String, List<File>> entry : rooms.entrySet()) {
//            String mapKey = entry.getKey();
//            List<File> room= entry.getValue();
//            System.out.println(mapKey);
//            for(File f:room){
//                System.out.println(f.length());
//            }
//        }
        return rooms;
    }

    @Override
    public Integer addGoods(Goods goods, MultipartFile file) throws IOException {
//        String basePath = "C:\\Users\\61580\\Desktop\\storage";
        String basePath = "/usr/local/images";
        String filePath = basePath + File.separator + file.getOriginalFilename();
        File f = new File(basePath);
        if (!f.exists()) {
            f.mkdirs();
        }
        String filename = file.getOriginalFilename();
        OutputStream fos = new FileOutputStream(filePath);
        InputStream fis = file.getInputStream();
        byte[] bs = new byte[1024];
        int len;
        while ((len = fis.read(bs)) != -1) {
            fos.write(bs, 0, len);
        }
        fos.close();
        fis.close();
        goods.setImageUrl("http://www.tzdian.top:8080/images/"+filename);
//        goods.setStartDate(LocalDateTime.now());
//        goods.setEndDate(Loca);
        GM.addGoods(goods);
        return null;
    }

    @Override
    public Integer deleteGoods(Integer id) {
        String basePath = "/usr/local/images";
        Goods goods = GM.getGoodsById(id);
        if (goods == null)
            throw new BizException(BizErrorCodeEnum.NOT_FOUND);
        String imageUrl = goods.getImageUrl();
        Integer index = imageUrl.lastIndexOf('/')+1;
        String fileName = imageUrl.substring(index);
        File file = new File(basePath + File.separator +fileName);
        file.delete();
        return GM.deleteGoods(id);
    }
}
