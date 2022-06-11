import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class AppController extends GetxController with GetTickerProviderStateMixin {
  late TabController buttonBarController;
  late Color buttonBarBackgroundColor;

  void changeThemeData() {
    buttonBarBackgroundColor =
        CustomThemeDate.getMaterialColor(CustomCfg.color);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    buttonBarController = TabController(length: 3, vsync: this);
    buttonBarController.index = 1;
    buttonBarBackgroundColor =
        CustomThemeDate.getMaterialColor(CustomCfg.color);
    print("appcontroller init ...");
  }

  @override
  void onClose() {
    super.onClose();
    buttonBarController.dispose();
  }
}
