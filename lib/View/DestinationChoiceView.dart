import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'select_destination.dart';
import 'SettingsView.dart';

class DestinationChoiceView extends StatelessWidget {
  bool selected = false;
  List<LatLng> puntos = [
    LatLng(4.60140465 + 0.0003, -74.0649032880709), // Punto 1
    LatLng(4.60140465 - 0.0003, -74.0649032880709),
    LatLng(4.60140465 - 0.0003, -74.0649032880709 + 0.0003), // Punto 2
  ];

  DestinationChoiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              const SafeGoMap(),
              Positioned(
                top: 32, // Adjust the position as needed
                left: 16, // Adjust the position as needed
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(152, 204, 180, 1),
                  ),
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SettingsView(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.menu)),
                ),
              ),
            ]),
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
