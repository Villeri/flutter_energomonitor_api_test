import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_energomonitor_api_test/energyinfo_list.dart';
import 'package:http/http.dart' as http;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class EnergyInfoGraph extends StatefulWidget {
  const EnergyInfoGraph({
    super.key,
  });

  @override
  State<EnergyInfoGraph> createState() => _EnergyInfoGraphState();
}

class _EnergyInfoGraphState extends State<EnergyInfoGraph> {
  List<_EnergyData> dataList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String token = "jOiuBqByBepxsxBB3TqLolHFSBlgC7";
    final response = await http.get(
      Uri.parse(
          "https://api.energomonitor.com/v1/feeds/emphhy/streams/emphig/data?limit=10"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    final responseJson = jsonDecode(response.body);
    for (var i = 0; i < responseJson.length; i++) {
      dataList.add(_EnergyData(responseJson[i][0], responseJson[i][1]));
      print("timestamp: ${responseJson[i][0]} energy: ${responseJson[i][1]}");
    }
  }

  checkValue() {
    if (dataList.isNotEmpty) {
      return Column(
        children: [
          SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            title: ChartTitle(text: "Energy info"),
            legend: Legend(isVisible: true),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<_EnergyData, String>>[
              LineSeries<_EnergyData, String>(
                dataSource: dataList,
                xValueMapper: (_EnergyData energy, _) =>
                    energy.timestamp.toString(),
                yValueMapper: (_EnergyData energy, _) => energy.energyvalue,
                name: "Spent energy",
                dataLabelSettings: DataLabelSettings(isVisible: true),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SfSparkLineChart.custom(
                trackball: SparkChartTrackball(
                    activationMode: SparkChartActivationMode.tap),
                marker: SparkChartMarker(
                  displayMode: SparkChartMarkerDisplayMode.all,
                ),
                labelDisplayMode: SparkChartLabelDisplayMode.all,
                xValueMapper: (int index) => dataList[index].timestamp,
                yValueMapper: (int index) => dataList[index].energyvalue,
                dataCount: 10,
              ),
            ),
          )
        ],
      );
    }
    return Text("No values found. DataList length is ${dataList.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Energy info graph"),
      ),
      body: checkValue(),
    );
  }
}

class _EnergyData {
  _EnergyData(this.timestamp, this.energyvalue);

  final int timestamp;
  final int energyvalue;
}
