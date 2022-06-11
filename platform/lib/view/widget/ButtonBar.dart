import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/AppController.dart';

Widget MyButtonBar() {
  List route = ['/add', '/room', '/chart'];
  return GetBuilder<AppController>(
    builder: (controller) => ConvexAppBar(
      items: [
        TabItem(icon: Icons.add, title: 'Add'.tr),
        TabItem(icon: Icons.home, title: 'Home'.tr),
        TabItem(icon: Icons.timelapse, title: 'Chart'.tr),
      ],
      backgroundColor: controller.buttonBarBackgroundColor,
      initialActiveIndex: 1, //optional, default as 0
      onTap: (int i) => Get.toNamed(route[i]),
      controller: Get.find<AppController>().buttonBarController,
      color: Colors.black,
      // style: Ta,
    ),
  );
}
