import 'package:flutter/material.dart';
import 'package:flutter_energomonitor_api_test/last10mins_energyprices/energy_prices_info_charts.dart';
import 'package:flutter_energomonitor_api_test/last10mins_energyprices/energy_prices_info_list.dart';

class Last10MinsEnergyPrices extends StatefulWidget {
  Last10MinsEnergyPrices({
    Key? key,
    required this.accessToken,
  }) : super(key: key);

  String accessToken;

  @override
  State<Last10MinsEnergyPrices> createState() => _Last10MinsEnergyPricesState();
}

class _Last10MinsEnergyPricesState extends State<Last10MinsEnergyPrices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Last 10 minutes energy prices"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnergyPricesInfoList(
                              accessToken: widget.accessToken,
                            )));
              },
              child: const Text("View energy price info list"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EnergyPricesInfoCharts(
                              accessToken: widget.accessToken,
                            )));
              },
              child: const Text("View energy price info charts"),
            ),
          ],
        ),
      ),
    );
  }
}
