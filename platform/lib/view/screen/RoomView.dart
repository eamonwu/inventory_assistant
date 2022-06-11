import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/AppController.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:inventor_assistant/view/screen/DrawerScreen.dart';
import 'package:inventor_assistant/view/widget/ButtonBar.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class RoomView extends StatelessWidget {
  RoomView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<RoomViewController>(RoomViewController());
    Get.put(AppController());
    return GetBuilder<RoomViewController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: DrawerScreen(),
        mainScreen: MainScreen(),
        borderRadius: 24.0,
        showShadow: true,
        menuBackgroundColor: CustomThemeDate.menuBackgroundColor,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomViewController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () => controller.toggleDrawer(),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home),
                Text(
                  "My Room".tr,
                  style: CustomThemeDate.wTitleStyle,
                ),
              ],
            ),
            centerTitle: true,
            bottom: TabBar(
              isScrollable: true,
              tabs: controller.tabs.map((e) {
                return Text(e);
              }).toList(),
              controller: controller.tabController,
            ),
            actions: [
              IconButton(
                onPressed: () => controller.changeTheSort(),
                icon: Icon(Icons.sort),
              ),
              IconButton(
                onPressed: () => controller.changeLayout(),
                icon: Icon(Icons.window),
              ),
            ],
          ),
          body: TabBarView(
            children: controller.createRoomTabbarView(),
            controller: controller.tabController,
          ),
          bottomNavigationBar: MyButtonBar(),
        );
      },
    );
  }
}
