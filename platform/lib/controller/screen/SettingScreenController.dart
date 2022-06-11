import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class SettingScreenController extends GetxController {
  bool sort = CustomCfg.sort;
  bool layout = CustomCfg.layout;
  bool language = true;
  bool auto = CustomCfg.auto;
  Color currentColor = CustomThemeDate.getMaterialColor(CustomCfg.color);
  RoomViewController rsc = Get.find<RoomViewController>();

  void sortChange(bool newValue) async {
    await rsc.changeTheSort();
    sort = newValue;
    update();
  }

  void layoutChange(bool newValue) async {
    await rsc.changeLayout();
    layout = newValue;
    print(layout);
    update();
  }

  void autoChange(bool newValue) async {
    await rsc.changeAuto();
    auto = newValue;
    update();
  }
}
