
import 'package:flutter/material.dart';
import 'select_destination.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Esta biblioteca proporciona un tipo de datos LatLng para ubicaciones geográficas.
import 'package:flutter/services.dart' show rootBundle; // Para cargar archivos desde assets.
import 'dart:convert'; // Para trabajar con datos GeoJSON.

void main() {
  runApp(const SafeGo());
}

class SafeGo extends StatelessWidget {
  const SafeGo({super.key});

  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool selected = false;
  List<LatLng> puntos = [
    LatLng(4.60140465 + 0.0003, -74.0649032880709),   // Punto 1
    LatLng(4.60140465 - 0.0003, -74.0649032880709),
    LatLng(4.60140465 - 0.0003, -74.0649032880709 +  0.0003),   // Punto 2
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
                children:[
                  SizedBox(
                    width: 410,
                    height: 470,

                    child: FlutterMap(
                      options: MapOptions(
                        interactiveFlags: InteractiveFlag.none,
                        center: LatLng(4.60140465, -74.0649032880709), // Ubicación inicial del mapa
                        zoom: 18.0, // Nivel de zoom inicial
                      ),
                      children: [
                        // Agrega una capa de mapa base, por ejemplo, OpenStreetMap
                        TileLayer(
                          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                          subdomains: const ['a', 'b', 'c'],
                        ),
                      ],
                    ),
                  ),
                ]
            ),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      AnimatedContainer(
                        padding: const EdgeInsets.only(left: 40, bottom: 20, right: 40),
                        alignment: selected ? Alignment.bottomCenter : AlignmentDirectional.bottomCenter,
                        duration: const Duration(seconds: 1),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(152, 204, 180, 1),
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                        ),
                        curve: Curves.linear,
                        child: (1 == 1) ?const SelectDestination() : const SelectDestination(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),

    );
  }
}

