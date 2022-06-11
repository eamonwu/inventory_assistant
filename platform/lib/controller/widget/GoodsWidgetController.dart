import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/model/Goods.dart';
import 'package:palette_generator/palette_generator.dart';

class GoodsWidgetController extends GetxController {
  PaletteGenerator? paletteGenerator;
  ImageProvider? imageProvider;
  Goods goods;
  Color? color;
  GoodsWidgetController(this.goods);

  // Rect rect = Offset(20, 0);
  Future loadPaletteGenerator(ImageProvider imageProvider) async {
    // Rect r = Offset.zero
    // imageProvider.resolve(configuration)
    if (CustomCfg.auto) {
      paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        // region: Rect.fromLTRB(500, 0, 600, 600),
        // size: imageProvider.resolve(configuration)
      );
      color = paletteGenerator?.dominantColor?.color;
    }
    update();
  }

  void changeSort() {
    update();
  }

  static void deleteGoods(String roomName, String goodsId) {
    final rvc = Get.find<RoomViewController>();
    rvc.deleteGoods(goodsId, roomName);
  }

  @override
  void onInit() async {
    super.onInit();
    imageProvider = CustomCfg.online
        ? NetworkImage(goods.imageUrl, scale: 1)
        : FileImage(File(goods.imageUrl)) as ImageProvider;
    if (imageProvider == null) imageProvider = AssetImage("assetName");
    await loadPaletteGenerator(imageProvider!);
    // print('loda');
  }
}
