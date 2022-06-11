import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/model/Goods.dart';

class ExpireCount {
  final int tag;
  final int count;

  ExpireCount(this.tag, this.count);
}

class ChartScreenController extends GetxController {
  Map<String, List<Goods>> rooms = Get.find<RoomViewController>().rooms;
  List<ExpireCount> expireCount = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final zoomDrawerController = ZoomDrawerController();

  @override
  void onInit() {
    super.onInit();
    expireCountInit();
  }

  void expireCountInit() {
    Map<int, int> temp = {
      0: 0,
      1: 0,
      2: 0,
    };
    rooms.forEach((key, value) {
      value.forEach((element) {
        DateTime dateTime = DateTime.parse(element.endDate);
        if (dateTime.isBefore(DateTime.now().add(Duration(days: 1)))) {
          temp[0] = temp[0]! + 1;
        } else if (dateTime.isBefore(DateTime.now().add(Duration(days: 7)))) {
          temp[1] = temp[1]! + 1;
        } else {
          temp[2] = temp[2]! + 1;
        }
      });
    });
    int i = 0;
    temp.forEach((key, value) {
      expireCount.add(ExpireCount(i++, value));
    });
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }
}
