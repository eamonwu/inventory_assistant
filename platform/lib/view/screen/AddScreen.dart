import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inventor_assistant/controller/screen/AddController.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:inventor_assistant/view/screen/DrawerScreen.dart';
import 'package:inventor_assistant/view/widget/ButtonBar.dart';
import 'package:inventor_assistant/view/widget/InputFiled.dart';

List colors = [
  Color.fromARGB(255, 1, 136, 5),
  Color.fromARGB(255, 207, 187, 8),
  Colors.red,
];

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  Widget _buildImageAddAndPre() {
    return GetBuilder<AddController>(
      id: "image",
      builder: (controller) {
        return Container(
          child: controller.path != null
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 200,
                        child: Image.file(
                          File(controller.path!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Align(
                      child: InkWell(
                        onTap: () => controller.resetImage(),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.grey,
                        ),
                      ),
                      alignment: Alignment.topRight,
                    ),
                  ],
                )
              : GestureDetector(
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        size: 88,
                      ),
                    ),
                  ),
                  onTap: () => controller.cameraPiker(),
                ),
        );
      },
    );
  }

  Widget _buildDatePiker(AddController addController, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GetBuilder<AddController>(
            builder: ((controller) {
              return InputField(
                title: "Start Date".tr,
                hint: formatDate(
                    controller.startDate, [yy, '年', mm, '月', dd, '日']),
                widget: IconButton(
                  icon: (Icon(
                    Icons.date_range,
                    color: Colors.grey,
                  )),
                  onPressed: () {
                    addController.showStartDatePicker(context);
                  },
                ),
              );
            }),
          ),
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: GetBuilder<AddController>(
            builder: (controller) => InputField(
              title: "End Date".tr,
              hint: formatDate(controller.endDate, [yy, '年', mm, '月', dd, '日']),
              widget: IconButton(
                icon: (Icon(
                  Icons.date_range_sharp,
                  color: Colors.grey,
                )),
                onPressed: () {
                  controller.showEndDatePicker(context);
                },
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAddTF(
      TextEditingController goodsName, TextEditingController annotation) {
    return Column(
      children: [
        InputField(
          title: "Goods Name".tr,
          hint: "Enter Name here.".tr,
          controller: goodsName,
        ),
        InputField(
          title: "Annotation".tr,
          hint: "Enter Annotation here.".tr,
          controller: annotation,
        ),
      ],
    );
  }

  Widget _colorChips() {
    return GetBuilder<AddController>(
      builder: (controller) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Color".tr,
            style: CustomThemeDate.wTitleStyle,
          ),
          SizedBox(
            height: 8,
          ),
          Wrap(
            children: List<Widget>.generate(
              3,
              (int index) {
                // _index = index;
                return GestureDetector(
                  onTap: () => controller.selectedColorChange(index),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CircleAvatar(
                      radius: 14,
                      backgroundColor: colors[index],
                      child: index == controller.selectedColor
                          ? Center(
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 18,
                              ),
                            )
                          : Container(),
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
    // return
  }

  Widget _colorButton() {
    return GetBuilder<AddController>(
        builder: ((controller) => GestureDetector(
              onTap: () => Get.find<AddController>().add(),
              child: Container(
                height: 50,
                width: 130,
                decoration: BoxDecoration(
                  color: colors[controller.selectedColor],
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    "Create Task".tr,
                    style: CustomThemeDate.wTitleStyle,
                  ),
                ),
              ),
            )));

    //  return ;
  }

  Widget _buildColorChipsAndButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _colorChips(),
        _colorButton(),
      ],
    );
  }

  Widget _buildSelectGroup() {
    return GetBuilder<AddController>(
      builder: (controller) => InputField(
        title: "Classify".tr,
        hint: controller.selectGroupName,
        controller: controller.goodsGroup,
        widget: Row(
          children: [
            DropdownButton<String>(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
                iconSize: 32,
                elevation: 4,
                // style: CustomThemeDate.wTextStyle,
                underline: Container(height: 0),
                onChanged: (v) => controller.selectGroupNameChange(v),
                items: Get.find<RoomViewController>()
                    .tabs
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList()),
            SizedBox(width: 6),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Add Goods".tr,
            style: CustomThemeDate.wTitleStyle,
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => controller.toggleDrawer(),
          ),
          actions: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 16,
              child: InkWell(
                child: Icon(
                  Icons.center_focus_strong,
                  color: Colors.black.withOpacity(0.88),
                ),
                onTap: () {
                  controller.scanBarCode();
                },
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        bottomNavigationBar: MyButtonBar(),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildImageAddAndPre(),
                Divider(),
                _buildAddTF(controller.goodsName, controller.annotation),
                _buildDatePiker(controller, context),
                _buildSelectGroup(),
                SizedBox(height: 10),
                _buildColorChipsAndButton(),
                Divider(),
                Text(
                  "A bad pen is better than a good memory",
                  style: GoogleFonts.acme(),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AddScreen extends StatelessWidget {
  AddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<AddController>(AddController());
    return GetBuilder<AddController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: DrawerScreen(),
        mainScreen: MainScreen(),
        borderRadius: 24.0,
        showShadow: true,
        menuBackgroundColor: CustomThemeDate.menuBackgroundColor,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }
}
