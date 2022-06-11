import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventor_assistant/controller/widget/RoomWidgetController.dart';

class WaterFallRoomWidget extends StatelessWidget {
  final List<Widget> left;
  final List<Widget> right;
  final String roomName;

  WaterFallRoomWidget({
    Key? key,
    required this.left,
    required this.right,
    required this.roomName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rc = Get.find<RoomWidgetController>(tag: roomName);

    // 一个可上下滑动的Row
    return SingleChildScrollView(
      controller: rc.scrollController,
      child: GetBuilder<RoomWidgetController>(
        tag: roomName,
        builder: (controller) {
          return Container(
            constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - 60),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 30,
                  child: Column(
                    children: left,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
                ),
                Expanded(
                  flex: 30,
                  child: Column(
                    children: right,
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
