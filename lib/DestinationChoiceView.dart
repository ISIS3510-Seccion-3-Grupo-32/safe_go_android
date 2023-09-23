import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'select_destination.dart';
import 'TravelDataView.dart';

class DestinationChoiceView extends StatelessWidget {
  bool selected = false;
  List<LatLng> puntos = [
    LatLng(4.60140465 + 0.0003, -74.0649032880709), // Punto 1
    LatLng(4.60140465 - 0.0003, -74.0649032880709),
    LatLng(4.60140465 - 0.0003, -74.0649032880709 + 0.0003), // Punto 2
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
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
            child: AnimatedContainer(
              padding: const EdgeInsets.only(left: 40, bottom: 20, right: 40),
              alignment: selected
                  ? Alignment.bottomCenter
                  : AlignmentDirectional.bottomCenter,
              duration: const Duration(seconds: 1),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(152, 204, 180, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              curve: Curves.linear,
              child: (1 == 1)
                  ? const SelectDestination()
                  : const SelectDestination(),
            ),
          ),
        ],
      ),
    );
  }
}
