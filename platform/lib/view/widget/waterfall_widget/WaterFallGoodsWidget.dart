import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/widget/GoodsWidgetController.dart';
import 'package:inventor_assistant/global/CustomCfg.dart';
import 'package:inventor_assistant/model/Goods.dart';
import 'package:inventor_assistant/utilities/theme.dart';

class WaterFallGoodsWidget extends StatelessWidget {
  WaterFallGoodsWidget(this.goods, {Key? key}) : super(key: key) {}

  final Goods goods;
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

  Widget _buildGoodsDetails(GoodsWidgetController controller) {
    return GetBuilder<GoodsWidgetController>(
        tag: goods.id.toString(),
        builder: (controller) {
          Color? _color =
              Get.find<GoodsWidgetController>(tag: goods.id.toString())
                  .paletteGenerator
                  ?.dominantColor
                  ?.color;
          return Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image(
                    image: CustomCfg.online
                        ? NetworkImage(goods.imageUrl)
                        : FileImage(File(goods.imageUrl)) as ImageProvider,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) => Image.asset(
                      "assets/images/error.jpg",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _color ?? Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Divider(
                          height: 10,
                          thickness: 2,
                          indent: 10,
                          endIndent: 10,
                        ),
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
                        Row(
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
                  )
                ],
              ),
              Align(
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
                alignment: Alignment.topRight,
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Color color = _calcGoodsShowColor(goods.endDate);
    Get.put(
      GoodsWidgetController(goods),
      tag: goods.id.toString(),
    );
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.circular(20),
      ),
      shadowColor: color,
      elevation: 40,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 5,
            color: color,
          ),
        ),
        child: GetBuilder<GoodsWidgetController>(
          tag: goods.id.toString(),
          builder: (controller) => _buildGoodsDetails(controller),
        ),
      ),
    );
  }
}
