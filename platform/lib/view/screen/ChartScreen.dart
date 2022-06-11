import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:inventor_assistant/controller/screen/ChartScreenController.dart';
import 'package:inventor_assistant/controller/screen/RoomViewController.dart';
import 'package:inventor_assistant/utilities/theme.dart';
import 'package:inventor_assistant/view/screen/DrawerScreen.dart';
import 'package:inventor_assistant/view/widget/ButtonBar.dart';

class MyCount {
  final String name;
  final int num;

  MyCount(this.name, this.num);
}

Widget _buildPieChart(List<MyCount> data) {
  return Container(
    height: 200,
    child: charts.PieChart<String>(
      [
        charts.Series<MyCount, String>(
          id: 'Sales',
          domainFn: (MyCount c, _) => c.name,
          measureFn: (MyCount c, _) => c.num,
          labelAccessorFn: (MyCount c, _) => '${c.name}: ${c.num}',
          data: data,
        )
      ],
      defaultRenderer: charts.ArcRendererConfig(arcRendererDecorators: [
        charts.ArcLabelDecorator(labelPosition: charts.ArcLabelPosition.inside)
      ]),
    ),
  );
}

Widget _buildExpireBarChart(List<ExpireCount> data) {
  final nameMap = {
    0: '迫在眉睫1-',
    1: '坐立不安3-',
    2: '闲庭信步3+',
  };
  final colorMap = {
    0: charts.MaterialPalette.red.shadeDefault,
    1: charts.MaterialPalette.yellow.shadeDefault,
    2: charts.MaterialPalette.green.shadeDefault
  };
  return Container(
    height: 200,
    child: charts.BarChart(
      [
        charts.Series<ExpireCount, String>(
          id: 'Sales',
          colorFn: (ExpireCount e, __) => colorMap[e.tag]!,
          domainFn: (ExpireCount e, _) => nameMap[e.tag]!,
          measureFn: (ExpireCount e, _) => e.count,
          data: data,
        )
      ],
      animate: false,
    ),
  );
}

Widget _buildLineChart(List<ExpireCount> data) {
  final ticks = new charts.StaticNumericTickProviderSpec([
    new charts.TickSpec(
      0,
      label: '一天之内',
    ),
    new charts.TickSpec(
      1,
      label: '三天之内',
    ),
    new charts.TickSpec(
      2,
      label: '三天后',
    ),
  ]);
  return Container(
    height: 200,
    child: charts.LineChart(
      [
        charts.Series<ExpireCount, int>(
          id: 'Sales',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (ExpireCount e, _) => e.tag,
          measureFn: (ExpireCount e, _) => e.count,
          data: data,
        )
      ],
      animate: false,
      domainAxis: new charts.NumericAxisSpec(tickProviderSpec: ticks),
    ),
  );
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, int> count = Get.find<RoomViewController>().toChartData();
    List<MyCount> data = [];
    count.forEach((key, value) {
      data.add(MyCount(key, value));
    });
    return GetBuilder<ChartScreenController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            "Statistics".tr,
            style: CustomThemeDate.wTitleStyle,
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => controller.toggleDrawer(),
          ),
          centerTitle: true,
        ),
        body: Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                    child: data.isEmpty ? Container() : _buildPieChart(data)),
                Expanded(child: _buildLineChart(controller.expireCount)),
              ],
            ),
            Expanded(child: _buildExpireBarChart(controller.expireCount)),
            SizedBox(
              height: 40,
            )
          ],
        ),
        bottomNavigationBar: MyButtonBar(),
      ),
    );
  }
}

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put<ChartScreenController>(ChartScreenController());
    return GetBuilder<ChartScreenController>(
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
