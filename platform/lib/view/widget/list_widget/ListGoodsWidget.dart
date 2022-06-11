import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/widget/GoodsWidgetController.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/model/Goods.dart';
import 'package:inventor_assistant/utilities/theme.dart';

Color _calcGoodsShowColor(String date) {
  DateTime dateTime = DateTime.parse(date);
  if (dateTime.isBefore(DateTime.now().add(Duration(days: 1)))) {
    return Colors.red;
  } else if (dateTime.isBefore(DateTime.now().add(Duration(days: 3)))) {
    return Colors.yellow;
  } else {
    return Colors.green;
  }
}

class ListGoodsWidget extends StatelessWidget {
  final Goods goods;
  const ListGoodsWidget({
    required this.goods,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(
      GoodsWidgetController(goods),
      tag: goods.id.toString(),
    );
    Size size = MediaQuery.of(context).size;
    Color color = _calcGoodsShowColor(goods.endDate);
    return GetBuilder<GoodsWidgetController>(
      tag: goods.id.toString(),
      builder: (controller) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20),
        ),
        shadowColor: color,
        elevation: 8,
        child: Stack(
          children: [
            Container(
              height: size.width * 0.4,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: color,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: _buildListGoodsDetail(size.width * 0.4),
            ),
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () => GoodsWidgetController.deleteGoods(
                  goods.goodsGroup,
                  goods.id.toString(),
                ),
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildListGoodsDetail(double size) {
    // print(goods.id);
    // print("============");
    // print(Get.find<GoodsWidgetController>(tag: goods.id.toString()).color);
    return GetBuilder<GoodsWidgetController>(
        tag: goods.id.toString(),
        builder: (controller) {
          // print(controller.color);
          // print(
          //     Get.find<GoodsWidgetController>(tag: goods.id.toString()).color);
          // print("============");
          Color? _color =
              Get.find<GoodsWidgetController>(tag: goods.id.toString()).color;
          return Row(
            children: [
              Container(
                height: size,
                width: size,
                child: Image(
                  image: CustomCfg.online
                      ? NetworkImage(goods.imageUrl)
                      : FileImage(File(goods.imageUrl)) as ImageProvider,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                    "assets/images/error.jpg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  height: size,
                  decoration: BoxDecoration(color: _color ?? Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment),
                          Text(
                            goods.goodsName,
                            style: CustomThemeDate.wTextStyle,
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.bookmark_outline_rounded),
                            Expanded(
                              child: Text(
                                ": " +
                                    (goods.annotation == null
                                        ? "Empty...".tr
                                        : goods.annotation!),
                                softWrap: true,
                                style: CustomThemeDate.wTextStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.alarm),
                          Text(
                            formatDate(
                              DateTime.parse(goods.endDate),
                              [yyyy, '/', mm, '/', dd, '  ', hh, ':', nn],
                            ),
                            style: CustomThemeDate.wTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
