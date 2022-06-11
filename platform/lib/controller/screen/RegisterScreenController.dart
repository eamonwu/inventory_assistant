import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/global/Global.dart';

class RegisterScreenController extends GetxController {
  static RegisterScreenController get i => Get.find();

  var account = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var passwordConfirm = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    account = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    passwordConfirm = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    account.dispose();
    email.dispose();
    password.dispose();
    passwordConfirm.dispose();
  }

  void validate() {
    if (account.text.isBlank!) {}
  }

  Future register() async {
    await Global.getInstance()?.dio.post("/user/register", data: {
      "userAccount": account.text,
      "userPassword": password.text,
      "userEmail": email.text,
    }).then((resp) {
      if (resp.data["success"]) {
        Get.defaultDialog(
          title: "太棒了!!",
          content: Text(
            "注册成功",
            style: TextStyle(fontSize: 20),
          ),
        );
      } else {
        Get.defaultDialog(
          title: "呜呜呜",
          content: Text(
            resp.data["message"],
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    });
  }
}
