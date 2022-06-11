import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/global/Global.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  static LoginScreenController get i => Get.find();

  var account = TextEditingController();
  var password = TextEditingController();

  static void changeThemeData() {
    print("theme color change");

    //  Get.find<AppController>()
    Get.changeTheme(ThemeData(
      primarySwatch: CustomThemeDate.getMaterialColor(CustomCfg.color),
    ));
  }

  Future loadData() async {
    // 从SharedPreference中获取是否离线模式online
    // 如果online使用token登录
    // 否则直接进入用户界面
    // SharedPreferences sp = await SharedPreferences.getInstance();
    // bool? spOnline = sp.getBool("online");
    // Global.getInstance()!.online = spOnline == null ? true : spOnline;

// 获取全局配置

    // piins
    await CustomCfg.initConfig().then(
      (value) => changeThemeData(),
    );
    if (CustomCfg.online) {
      tokenLogin();
    } else {
      Global.getInstance()?.user = {"userAccount": "null", "userId": "null"};
      Get.offAndToNamed("/room");
    }
  }

  // 用户名密码登录
  Future login() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    print((sp.getString("token") ?? "null"));
    await Global.getInstance()?.dio.post("user/login", data: {
      "userAccount": account.text,
      "userPassword": password.text,
    }).then((resp) {
      if (resp.data["success"]) {
        print(resp.data);
        Global.getInstance()?.user = resp.data["user"];
        sp.setString("token", resp.data["token"]);
        Get.defaultDialog(
          title: "欢迎",
          content: Text(
            "登录成功",
            style: TextStyle(fontSize: 20),
          ),
        );
        Future.delayed(Duration(milliseconds: 800), () {
          Get.offAllNamed("/room");
        });
      } else {
        Get.defaultDialog(
          title: "登录失败",
          content: Text(resp.data["message"]),
          barrierDismissible: true,
        );
      }
    });
  }

  // 使用本地储存的token登录,失败后删除token,定向到登录页面
  Future tokenLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString("token");
    Global.getInstance()?.dio.options.headers["token"] = token;
    await Global.getInstance()?.dio.post("user/login", data: {
      "userAccount": "",
      "userPassword": "",
    }).then((resp) {
      if (resp.data["success"]) {
        Global.getInstance()?.user = resp.data["user"];
        Get.offAndToNamed("/room");
      } else {
        sp.remove("token");
      }
    });
  }

  Future vistorLogin() async {
    await CustomCfg.setOnline(false);
    Global.getInstance()?.user = {"userAccount": "null", "userId": "null"};
    Get.offAndToNamed("/room");
  }
}
