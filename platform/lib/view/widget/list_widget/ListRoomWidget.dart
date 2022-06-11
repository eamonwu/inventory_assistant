import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/widget/RoomWidgetController.dart';

class ListRoomWidget extends StatelessWidget {
  final List<Widget> goodsList;
  final String roomName;
  ListRoomWidget({
    Key? key,
    required this.goodsList,
    required this.roomName,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // widget.
    return GetBuilder<RoomWidgetController>(
        tag: roomName,
        builder: (controller) {
          return Container(
            decoration: BoxDecoration(
                // color: Color(0xffF8F1E4),
                color: Colors.white),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView(
              children: goodsList,
            ),
          );
        });
  }
}
