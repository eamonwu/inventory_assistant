import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/DrawerViewController.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);
  Widget _buildOption(IconData icon, String name, {Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 30,
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            name,
            style: CustomThemeDate.wTextStyle.copyWith(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dvc = DrawerViewController();
    return Container(
      decoration: BoxDecoration(
        color: CustomThemeDate.menuBackgroundColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "龙傲天",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              "615808706@qq.com",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage:
                  NetworkImage("https://www.itying.com/images/flutter/3.png"),
            ),
            decoration: BoxDecoration(
              color: CustomThemeDate.menuBackgroundColor,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _buildOption(Icons.settings, "setting".tr,
              onTap: () => Get.toNamed("/setting")),
          SizedBox(height: 25),
          _buildOption(Icons.share, "share".tr),
          SizedBox(height: 25),
          _buildOption(Icons.policy, "policy".tr),
          SizedBox(height: 10),
          Divider(
            thickness: 3,
          ),
          SizedBox(height: 10),
          InkWell(
            child: Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Icon(
                  Icons.exit_to_app,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  "EXIT".tr,
                  style: CustomThemeDate.wTextStyle.copyWith(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onTap: () => dvc.exitToApp(),
          )
        ],
      ),
    );
  }
}
