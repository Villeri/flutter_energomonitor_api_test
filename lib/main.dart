import 'package:flutter/material.dart';
import 'package:flutter_energomonitor_api_test/userinfo.dart';

import 'energyinfo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Energomonitor Api Test"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline),
            tooltip: "User info",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const UserInfo()));
            },
          )
        ],
      ),
      body: Center(
          child: Column(
        children: [
          const Text("Energomonitor api test"),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const EnergyInfo()));
            },
            child: const Text("View energy info"),
          ),
        ],
      )),
    );
  }
}
