import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/model/Goods.dart';
import 'package:inventor_assistant/view/widget/list_widget/ListGoodsWidget.dart';
import 'package:inventor_assistant/view/widget/list_widget/ListRoomWidget.dart';
import 'package:inventor_assistant/view/widget/waterfall_widget/WaterFallGoodsWidget.dart';
import 'package:inventor_assistant/view/widget/waterfall_widget/WaterFallRoomWidget.dart';

class RoomWidgetController extends GetxController {
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    super.onClose();
    // scrollController.dispose();
  }

  // 创建瀑布流布局的房间
  static Widget createWaterFallRoom(List<Goods> goodsList, String roomName) {
    int index = 0;
    List<WaterFallGoodsWidget> tempLeft = [];
    List<WaterFallGoodsWidget> tempRight = [];
    goodsList.forEach((goods) {
      if (index % 2 == 0) {
        tempLeft.add(WaterFallGoodsWidget(goods));
      } else {
        tempRight.add(WaterFallGoodsWidget(goods));
      }
      index++;
    });
    Get.put(RoomWidgetController(), tag: roomName);
    return WaterFallRoomWidget(
      left: tempLeft,
      right: tempRight,
      roomName: roomName,
    );
  }

  // 创建列表布局的房间
  static Widget createListRoom(List<Goods> goodsList, String roomName) {
    List<ListGoodsWidget> list = [];
    Get.put(RoomWidgetController(), tag: roomName);
    goodsList.forEach((goods) {
      list.add(ListGoodsWidget(goods: goods));
    });

    return ListRoomWidget(
      goodsList: list,
      roomName: roomName,
    );
  }
}
