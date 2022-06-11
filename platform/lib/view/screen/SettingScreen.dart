import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/SettingScreenController.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:settings_ui/settings_ui.dart';

class SettinScreen extends StatelessWidget {
  const SettinScreen({Key? key}) : super(key: key);

  List<ListTile> _getColorListTile() {
    List<ListTile> list = [];
    CustomThemeDate.colors.forEach((key, value) {
      list.add(
        ListTile(
          leading: Text(key),
          trailing: Container(
            width: 15,
            height: 15,
            color: value,
          ),
          onTap: () {
            CustomCfg.setColor(key);
          },
        ),
      );
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(SettingScreenController());

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.settings),
            Text(
              "Settings",
              style: CustomThemeDate.wTitleStyle,
            ),
          ],
        ),
      ),
      body: GetBuilder<SettingScreenController>(
        builder: (controller) => Container(
          child: SettingsList(
            sections: [
              SettingsSection(
                title: Text(
                  'Common'.tr,
                  style: CustomThemeDate.wTitleStyle,
                ),
                tiles: <SettingsTile>[
                  SettingsTile.navigation(
                    leading: Icon(Icons.language),
                    title: Text(
                      'Language'.tr,
                      style: CustomThemeDate.wTitleStyle,
                    ),
                    value: Text(
                      'English',
                      style: CustomThemeDate.wTextStyle,
                    ),
                    onPressed: (_) {
                      Get.bottomSheet(
                        Container(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: Icon(Icons.abc),
                                title: Text("English"),
                                onTap: () {
                                  Get.updateLocale(Locale('en', 'US'));
                                  Get.back();
                                },
                              ),
                              ListTile(
                                leading: Text("简"),
                                title: Text("简体中文"),
                                onTap: () {
                                  Get.updateLocale(Locale('zh', 'CN'));
                                  Get.back();
                                },
                              )
                            ],
                          ),
                        ),
                        backgroundColor: Colors.white,
                        elevation: 0,
                      );
                    },
                  ),
                ],
              ),
              SettingsSection(
                title: Text(
                  "Swatch".tr,
                  style: CustomThemeDate.wTitleStyle,
                ),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      controller.sortChange(value);
                    },
                    initialValue: controller.sort,
                    leading: Icon(Icons.sort),
                    title: Text(
                      'Strat-date OR End-date'.tr,
                      style: CustomThemeDate.wTitleStyle,
                    ),
                  ),
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      controller.layoutChange(value);
                    },
                    initialValue: controller.layout,
                    leading: Icon(Icons.window_rounded),
                    title: Text(
                      'Water-fall OR List'.tr,
                      style: CustomThemeDate.wTitleStyle,
                    ),
                  ),
                  SettingsTile.navigation(
                    leading: Icon(Icons.format_paint),
                    title: Text(
                      'Color'.tr,
                      style: CustomThemeDate.wTitleStyle,
                    ),
                    value: Text(
                      'Enable custom theme'.tr,
                      style: CustomThemeDate.wTextStyle,
                    ),
                    trailing: Container(
                      height: 20,
                      width: 20,
                      color: controller.currentColor,
                    ),
                    onPressed: (_) => Get.bottomSheet(
                      SingleChildScrollView(
                        child: Container(
                          child: Wrap(
                            children: _getColorListTile(),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: Text(
                  "Advance".tr,
                  style: CustomThemeDate.wTitleStyle,
                ),
                tiles: <SettingsTile>[
                  SettingsTile.switchTile(
                    onToggle: (value) {
                      controller.autoChange(value);
                      // print(CustomCfg.auto);
                    },
                    initialValue: controller.auto,
                    leading: Icon(Icons.color_lens),
                    title: Text(
                      'Auto complete Background Color'.tr,
                      style: CustomThemeDate.wTextStyle,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
