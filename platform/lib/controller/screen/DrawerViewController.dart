import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerViewController extends GetxController {
  // final zoomDrawerController = ZoomDrawerController();

  Future exitToApp() async {
    Get.defaultDialog(
      title: "确认登出",
      content: Text(""),
      textConfirm: "确定",
      textCancel: "取消",
      onConfirm: () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.remove("token");
        await CustomCfg.setOnline(true);
        Get.offAllNamed("/login");
      },
    );
  }
}
