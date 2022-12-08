import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//https://api.energomonitor.com/v1/feeds/emphhy/streams/emphig/data?limit=10

Future<List<EnergyData>> fetchEnergyData() async {
  String token = "jOiuBqByBepxsxBB3TqLolHFSBlgC7";
  final response = await http.get(
    Uri.parse(
        "https://api.energomonitor.com/v1/feeds/emphhy/streams/emphig/data?limit=10"),
    headers: {
      "Authorization": "Bearer $token",
    },
  );
  /*List responseJson = jsonDecode(response.body);
  return responseJson.map((job) => EnergyData.fromJson(job)).toList();
  */
  final responseJson = jsonDecode(response.body);
  return responseJson;
}

class EnergyData {
  final List usedEnergyAmount;

  const EnergyData({
    required this.usedEnergyAmount,
  });

  factory EnergyData.fromJson(Map<List, dynamic> json) {
    return EnergyData(
      usedEnergyAmount: json["usedEnergyAmount"],
    );
  }
}

class EnergyInfo extends StatefulWidget {
  const EnergyInfo({Key? key}) : super(key: key);

  @override
  State<EnergyInfo> createState() => _EnergyInfoState();
}

class _EnergyInfoState extends State<EnergyInfo> {
  //late Future<EnergyData> futureEnergyData;
  //late final fetchedData;
  List dataList = [];

  @override
  void initState() {
    super.initState();
    getData();
    //futureEnergyData = fetchEnergyData() as Future<EnergyData>;
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
      dataList.add(responseJson[i]);
      print("timestamp: ${responseJson[i][0]} energy: ${responseJson[i][1]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Energy Info, ${dataList.length}"),
      ),
      body: Center(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              child: Center(
                child: Column(
                  children: [
                    Text(
                        "TIME: ${DateTime.fromMillisecondsSinceEpoch(dataList[index][0] * 1000)}"),
                    Text("ENERGY VALUE: ${dataList[index][1]}"),
                  ],
                ),
              ),
            );
          },
        ),
        /*child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 50,
                    child: Center(child: Text("${dataList[index]}")),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return const CircularProgressIndicator();
          },
        ),*/
      ),
    );
  }
}
