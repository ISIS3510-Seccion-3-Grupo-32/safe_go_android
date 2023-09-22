
import 'package:flutter/material.dart';
import 'package:safe_go_dart/start_ride.dart';
import 'select_destination.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
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
    return const MaterialApp(
      home: MyHomePage(),
    );

  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> mapLayouts = [
    TileLayer(
    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
    subdomains: const ['a', 'b', 'c'],
    ),
  ];
  List<LatLng> puntos = [
    LatLng(4.60140465 + 0.0003, -74.0649032880709),
    LatLng(4.60140465 - 0.0003, -74.0649032880709),
    LatLng(4.60140465 - 0.0003, -74.0649032880709 +  0.0003),
  ];
  int state = 0;
  void updateState(int newState) {
    setState(() {
      state = newState;
      mapLayouts.addAll([
        CircleLayer(
          circles: [
            CircleMarker(
              point: LatLng(4.60140465, -74.0649032880709), // Coordenadas del centro de la circunferencia
              radius: 200, // Radio en metros
              color: Colors.blue.withOpacity(0), // Color de la circunferencia con opacidad
              borderColor: Colors.black, // Color del borde de la circunferencia
              borderStrokeWidth: 4, // Ancho del borde
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 30.0,
              height: 30.0,
              point: puntos[0], // Coordenadas del centro de la circunferencia
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 30.0,
              height: 30.0,
              point: puntos[2], // Coordenadas del centro de la circunferencia
              builder: (ctx) => const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
        PolylineLayer(
          polylines: [
            Polyline(
              points: puntos,
              color: Colors.red, // Color de la línea
              strokeWidth: 2.0, // Ancho de la línea
            ),
          ],
        ),
      ]);
    });
  }
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
              width: constraints.maxWidth,
              height: constraints.maxWidth*1.155,

              child: FlutterMap(
                options: MapOptions(
                  interactiveFlags: InteractiveFlag.none,
                  center: LatLng(4.60140465, -74.0649032880709),
                  // Ubicación inicial del mapa
                  zoom: 18.0, // Nivel de zoom inicial
                ),
                children: mapLayouts,
                // Agrega una capa de mapa base, por ejemplo, OpenStreetMap

              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      padding: const EdgeInsets.only(
                          left: 40, bottom: 20, right: 40),
                      alignment: Alignment.bottomCenter,
                      duration: const Duration(seconds: 1),
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(152, 204, 180, 1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50)),
                      ),
                      curve: Curves.linear,
                      child: (state == 0) ? SelectDestination(trigger: updateState) : const StartRide(),
                          ),
                        ],
                      ),
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

