import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/widget/RoomWidgetController.dart';
import 'package:inventor_assistant/db/DBHelper.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/global/Global.dart';
import 'package:inventor_assistant/model/Goods.dart';
import 'package:inventor_assistant/utilities/local_notification.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RoomViewController extends GetxController
    with GetTickerProviderStateMixin {
  static RoomViewController get i => Get.find();

  final List<String> tabs = [];
  final rooms = Map<String, List<Goods>>();
  final zoomDrawerController = ZoomDrawerController();
  late TabController tabController;

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 0, vsync: this);
    await loadData().then((value) {
      tabController = TabController(length: tabs.length, vsync: this);
      update();
      notificate();
      // var notification = MyNotification();
      // notification.init();
      // notification.send("物品即将到期", "hello");
    });
  }

  @override
  void onClose() async {
    super.onClose();
    // tabController.dispose();
    await SharedPreferences.getInstance().then((value) {
      value.remove("tabs");
      value.remove("分类测试".hashCode.toString());
    });
  }

  //加载物品数据 最终使得rooms是一个 <String,List<dynamic>>
  Future loadData() async {
    // 离线模式和在线模式
    print("loda data");
    if (CustomCfg.online) {
      await lodaDataOnline();
    } else {
      await lodaDataOffline();
    }
    rooms.forEach((key, goodsList) {
      goodsList.sort((a, b) {
        bool flag =
            DateTime.parse(a.endDate).isBefore(DateTime.parse(b.endDate));
        return flag != CustomCfg.sort ? 1 : 0;
      });
    });
  }

  Future lodaDataOnline() async {
    await Global.getInstance()?.dio.get("/goods/rooms", queryParameters: {
      "userId": Global.getInstance()?.user!["id"],
    }).then((resp) {
      if (resp.data["success"]) {
        // print("获取房间成功");
        // print(resp.data["data"].toString());
        Map<String, dynamic>.from(resp.data['data'])
            //key是房间名,value是一个list,包含改房间中所有物品
            .forEach((roomName, goodsList) {
          tabs.add(roomName);
          rooms[roomName] = List<dynamic>.from(goodsList)
              .map((e) => Goods.fromJson(e))
              .toList();
        });
      }
    });
  }

  Future lodaDataOffline() async {
    await DBHelper.initDb();
    rooms["未分类"] = [];
    tabs.add("未分类");
    List<Map<String, dynamic>> goodsList = await DBHelper.query();
    //所有物品goods
    List<Goods> goods = [];
    goods.assignAll(goodsList.map((data) => Goods.fromJson(data)).toList());
    for (Goods g in goods) {
      if (rooms[g.goodsGroup] == null) {
        rooms[g.goodsGroup] = [];
        tabs.add(g.goodsGroup);
      }
      rooms[g.goodsGroup]!.add(g);
    }
  }

  void deleteGoods(String goodsId, String roomName) async {
    Get.defaultDialog(
      title: "确认删除",
      content: Text("这会使改物品永久删除"),
      textConfirm: "确定",
      textCancel: "取消",
      onConfirm: () async {
        await (CustomCfg.online
                ? deleteGoodsOnline(goodsId, roomName)
                : deleteGoodsOffline(goodsId, roomName))
            .then((value) {
          this.loadData().then(
            (value) {
              // 查找tabbar中roomName和原先相同的index
              int index = 0;
              for (int i = 0; i < tabs.length; i++) {
                if (tabs[i] == roomName) {
                  index = i;
                  break;
                }
              }
              //因为tabbar长度可能会变化,所以需要更新
              //将新的tabbar的index(默认为0)修改应该在的位置
              tabController = TabController(length: tabs.length, vsync: this);
              tabController.index = index;
              update();
            },
          );
          Get.back();
        });
      },
    );

    //请求加载成功后
  }

  Future deleteGoodsOnline(String goodsId, String roomName) async {
    await Global.getInstance()?.dio.delete("goods", queryParameters: {
      "id": goodsId,
    }).then((resp) {
      if (resp.data["success"]) {
        tabs.clear();
        rooms.clear();
        Get.back();
        Get.defaultDialog(
          title: "删除成功",
          middleText: "",
        );
      }
    });
  }

  Future deleteGoodsOffline(String goodsId, String roomName) async {
    await DBHelper.initDb();
    await DBHelper.delete(int.parse(goodsId)).then(
      (value) {
        tabs.clear();
        rooms.clear();
        Get.back();
        Get.defaultDialog(
          title: "删除成功",
          middleText: "",
        );
      },
    );
  }

  Future addGoodsOnline() async {
    await loadData().then((value) => update());
  }

  Future addGoodsOffline() async {
    await loadData().then((value) => update());
  }

  //改变布局 --瀑布流&&列表式
  Future changeLayout() async {
    await CustomCfg.setLayout(!CustomCfg.layout);
    update();
  }

  //改变排序 --按起始时间||到期时间
  Future changeTheSort() async {
    await CustomCfg.setSort(!CustomCfg.sort);
    rooms.forEach((key, goodsList) {
      List<Goods> newGoodsList = [];
      newGoodsList.assignAll(goodsList.reversed);
      goodsList.clear();
      goodsList.addAll(newGoodsList);
    });
    // print("sort");
    update();
    // Future.delayed(Duration(milliseconds: 400), () => update());
  }

  Future changeAuto() async {
    await CustomCfg.setAuto(!CustomCfg.auto);
    update();
  }

  List<Widget> createRoomTabbarView() {
    List<Widget> roomList = [];
    rooms.forEach(
      (roomName, goodsList) {
        roomList.add(
          // 首先判断是否为空,为空:返回Center
          goodsList.isEmpty
              ? Center(
                  child: Text(
                    "Nothing...".tr,
                    style: CustomThemeDate.wTitleStyle.copyWith(fontSize: 35),
                  ),
                )
              // 为true,返回列表布局
              : (CustomCfg.layout
                  ? RoomWidgetController.createListRoom(
                      goodsList,
                      roomName,
                    )
                  : RoomWidgetController.createWaterFallRoom(
                      goodsList,
                      roomName,
                    )),
        );
      },
    );
    return roomList;
  }

  Map<String, int> toChartData() {
    Map<String, int> count = Map<String, int>();
    rooms.forEach((key, value) {
      count[key] = value.length;
    });
    return count;
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

  void notificate() async {
    var notification = MyNotification();
    notification.init();
    int advance = 3, count = 0;
    DateTime ddl = DateTime.now().add(Duration(days: advance));
    rooms.forEach((roomsName, goodsList) {
      goodsList.forEach((element) {
        DateTime endDate = DateTime.parse(element.endDate);
        //只通知三次
        if (endDate.isBefore(ddl) && count <= 3) {
          notification.send(
              "物品要到期啦!", element.goodsName + ":" + (element.annotation ?? ''));
          count++;
        }
      });
    });
  }
}
