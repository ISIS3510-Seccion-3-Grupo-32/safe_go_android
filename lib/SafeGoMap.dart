import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:safe_go_dart/logic/PermissionRequest.dart';
class SafeGoMap extends StatefulWidget {

  const SafeGoMap({Key? key}) : super(key: key);

  @override
  State<SafeGoMap> createState() => SafeGoMapState();
}
class SafeGoMapState extends State<SafeGoMap> {
  MapController mapController = MapController();
  LatLng userLocation = LatLng(0.0, 0.0);
  late PermissionRequest request;
  Location location = Location();

  @override
  void initState() {
    super.initState();
    init();
  }
  Future<void> init() async{
  PermissionRequest request = PermissionRequest(userLocation: userLocation);
  await request.requestLocationPermission(context);
  updateLocation();
}
  updateLocation()  {
    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        final latitude = currentLocation.latitude ?? 0.0; // Valor predeterminado si es nulo
        final longitude = currentLocation.longitude ?? 0.0; // Valor predeterminado si es nulo
        userLocation = LatLng(latitude, longitude);
        mapController.move(userLocation, 18.0);
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
        options: MapOptions(
        interactiveFlags: InteractiveFlag.none,
        center: userLocation,
        zoom: 18.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: const ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 30.0,
              height: 30.0,
              point: userLocation,
              builder: (ctx) => const Icon(Icons.location_on_outlined, size: 30, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }
}