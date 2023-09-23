import 'package:flutter/material.dart';
import 'select_destination.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

void main() {
  runApp(const SafeGo());
}

class SafeGo extends StatelessWidget {
  const SafeGo({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Go Safe Testing'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: constraints.maxWidth, // Use maximum available width
                  height:
                      constraints.maxHeight / 2, // Use half of available height
                  child: FlutterMap(
                    options: MapOptions(
                      interactiveFlags: InteractiveFlag.none,
                      center: LatLng(4.60140465, -74.0649032880709),
                      zoom: 18.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: const ['a', 'b', 'c'],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 40, bottom: 20, right: 40),
                    alignment: Alignment.bottomCenter,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(152, 204, 180, 1),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50)),
                    ),
                    child: const SelectDestination(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
