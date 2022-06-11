import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_luban/flutter_luban.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventor_assistant/controller/AppController.dart';
import 'package:inventor_assistant/db/DBHelper.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/global/Global.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:inventor_assistant/model/Goods.dart';

class AddController extends GetxController {
  static AddController get i => Get.find();
  final ImagePicker imagePicker = ImagePicker();
  final zoomDrawerController = ZoomDrawerController();
  late TextEditingController goodsName;
  late TextEditingController annotation;
  late TextEditingController goodsGroup;
  late ScrollController scrollController;
  int selectedColor = 1;

  String selectGroupName = "未分类";

  var endDate = DateTime.now();
  var startDate = DateTime.now();
  var endTime = TimeOfDay.now();
  String? path;

  @override
  void onInit() {
    super.onInit();
    goodsName = TextEditingController();
    annotation = TextEditingController();
    goodsGroup = TextEditingController();
    goodsGroup.text = "未分类";
    scrollController = ScrollController();
  }

  @override
  void onClose() {
    super.onClose();
    goodsName.dispose();
    annotation.dispose();
    goodsGroup.dispose();
    scrollController.dispose();
  }

  String dateParse(DateTime dateTime) {
    String time = dateTime.toString().replaceFirstMapped(' ', (match) => 'T');
    return time;
  }

  Future add() async {
    if (path == null) return false;

    File file = File(path!);
    CompressObject compressObject = CompressObject(
      imageFile: file, //image
      path: file.path.substring(
        0,
        file.path.lastIndexOf('/'),
      ), //compress to path
      quality: 85, //first compress quality, default 80
      step:
          9, //compress quality step, The bigger the fast, Smaller is more accurate, default 6
      mode: CompressMode.LARGE2SMALL, //default AUTO
    );
    String? compressPath = await Luban.compressImage(compressObject);

    if (compressPath == null) return;

    Map goods = {
      "ownerId": Global.getInstance()?.user!["id"],
      "goodsGroup": goodsGroup.text,
      "goodsName": goodsName.text,
      "annotation": annotation.text,
      "startDate": dateParse(startDate),
      "endDate": dateParse(endDate),
    };
    if (CustomCfg.online) {
      var goodsJson = jsonEncode(goods);
      Response resp = await GetConnect().post(
        // "http://2.0.0.1:8888/assistant/goods",
        "http://www.tzdian.top:8888/assistant/goods",
        FormData({
          "goods": goodsJson,
          "file": await MultipartFile(
              await File(compressPath).readAsBytesSync(),
              filename:
                  compressPath.substring(compressPath.lastIndexOf("/") + 1))
        }),
      );
      if (resp.body["success"]) {
        Get.defaultDialog(
          title: "添加成功",
          middleText: "即将返回主界面",
        );
        Future.delayed(Duration(seconds: 2), () {}).then((value) {
          Get.offAllNamed('/room');
          Get.find<AppController>().buttonBarController.index = 1;
        });
      }
    } else {
      await DBHelper.initDb();
      await DBHelper.insert(
        Goods(
          id: 0,
          goodsGroup: goodsGroup.text,
          goodsName: goodsName.text,
          imageUrl: path ?? "https://",
          startDate: startDate.toString(),
          endDate: endDate.toString(),
          annotation: annotation.text,
        ),
      );
      Get.defaultDialog(
        title: "添加成功",
        middleText: "即将返回主界面",
      );
      Future.delayed(Duration(milliseconds: 1200), () {}).then((value) {
        Get.offAllNamed('/room');
        Get.find<AppController>().buttonBarController.index = 1;
      });
    }
  }

  Future<void> galleryPiker() async {
    await imagePicker
        .pickImage(source: ImageSource.gallery)
        .then((value) => path = value?.path);
    update(["image"]);
  }

  Future<void> cameraPiker() async {
    // XFile? x;
    await imagePicker
        .pickImage(source: ImageSource.camera)
        .then((value) => path = value?.path);
    print(path.toString());
    update(["image"]);
  }

  Future<void> showStartDatePicker(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        startDate = value;
        update();
      }
    });
  }

  Future<void> showEndDatePicker(BuildContext context) async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((value) {
      if (value != null) {
        endDate = value;
        update();
      }
    });
  }

  resetImage() {
    path = null;
    update(["image"]);
  }

  void selectGroupNameChange(String? newValue) {
    if (newValue == null)
      return;
    else
      goodsGroup.text = newValue;
    update();
  }

  void selectedColorChange(int index) {
    selectedColor = index;
    update();
  }

  Future scanBarCode() async {
    var options = const ScanOptions(
        //是否自动打开闪光灯
        autoEnableFlash: true,
        strings: {
          'cancel': '取消',
          'flash_on': '打开flash',
          'flash_off': '关闭flash'
        });
    ScanResult result = await BarcodeScanner.scan(options: options);
    // if(result.type)
    await GetConnect()
        .get("https://www.mxnzp.com/api/barcode/goods/details", query: {
      "barcode": result.rawContent,
      "app_id": "ppfo7kpmxthonifp",
      "app_secret": "cWdPWjdMTkcrVlFoSUpWLzZrVndZUT09",
    }).then((resp) {
      if (resp.body["code"] == 1) {
        goodsName.text = resp.body["data"]["goodsName"];
        annotation.text = "  物品名称 " +
            resp.body["data"]["goodsName"] +
            "  规格:  " +
            resp.body["data"]["standard"];
      } else {
        Get.defaultDialog(
          title: "添加失败",
          content: Text(resp.body["data"]["msg"]),
        );
      }
    });
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }
}
