import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/routes/routes.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:inventor_assistant/utilities/transition.dart';
import 'package:inventor_assistant/view/screen/LoginView.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  runApp(
    GetMaterialApp(
      theme: ThemeData(
        // primarySwatch: CustomThemeDate.getMaterialColor(CustomCfg.color),
        primarySwatch: CustomThemeDate.getMaterialColor('简约蓝'),
      ),
      home: LoginScreen(),
      getPages: Routes,
      debugShowCheckedModeBanner: false,
      translations: Messages(),
      locale: Locale('en', 'US'),
      fallbackLocale: Locale("zh", "CN"),
    ),
  );
}
