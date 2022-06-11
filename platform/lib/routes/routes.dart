import 'package:get/get.dart';
import 'package:inventor_assistant/view/screen/AddScreen.dart';
import 'package:inventor_assistant/view/screen/ChartScreen.dart';
import 'package:inventor_assistant/view/screen/LoginView.dart';
import 'package:inventor_assistant/view/screen/RegisterView.dart';
import 'package:inventor_assistant/view/screen/RoomView.dart';
import 'package:inventor_assistant/view/screen/SettingScreen.dart';

List<GetPage> Routes = [
  GetPage(
    name: "/login",
    page: () => LoginScreen(),
    transition: Transition.fadeIn,
    transitionDuration: Duration(milliseconds: 1200),
  ),
  GetPage(
    name: "/register",
    page: () => RegisterView(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: "/room",
    page: () => RoomView(),
  ),
  GetPage(
    name: "/chart",
    page: () => ChartScreen(),
  ),
  GetPage(
    name: "/add",
    page: () => AddScreen(),
  ),
  GetPage(
    name: "/setting",
    page: () => SettinScreen(),
  ),
];
