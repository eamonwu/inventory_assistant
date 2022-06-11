import 'package:get/get.dart';
import 'package:inventor_assistant/controller/AppController.dart';
import 'package:inventor_assistant/controller/screen/LoginController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomCfg {
  static late bool online;
  static late bool sort;
  static late bool layout;
  static late bool auto;
  static late String color;
  // Locale locale =

  // static String
  static Future<void> initConfig() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    // 默认离线
    // sp.clear();
    online = sp.getBool("online") ?? true;
    // 默认开启自动填充
    auto = sp.getBool("auto") ?? true;
    // 默认按结束时间排序
    sort = sp.getBool("sort") ?? true;
    // 默认列表展示
    layout = sp.getBool("layout") ?? true;
    // 默认绿色
    color = sp.getString("color") ?? "简约绿";
    // color = "简约绿";
  }

  static Future<void> setOnline(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    online = value;
    sp.setBool("online", value);
  }

  static Future<void> setSort(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sort = value;
    sp.setBool("sort", value);
  }

  static Future<void> setLayout(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    layout = value;
    sp.setBool("layout", value);
  }

  static Future<void> setAuto(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    auto = value;
    sp.setBool("auto", value);
  }

  static Future<void> setColor(String value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    color = value;
    sp.setString("color", value);
    Get.find<AppController>().changeThemeData();
    LoginScreenController.changeThemeData();
    // Future.delayed(Duration(seconds: 1), () {
    //   Get.forceAppUpdate();
    // });
    // Get.appUpdate();
  }
}
//room button chart add 