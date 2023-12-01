import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Model/PermissionRequest.dart';

class SafeGoMap extends StatefulWidget {
  const SafeGoMap({super.key});

  @override
  State<SafeGoMap> createState() => SafeGoMapState();
}

class SafeGoMapState extends State<SafeGoMap> {
  late GoogleMapController mapController;
  LatLng userLocation = const LatLng(4.6494536, -74.053825);
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  late PermissionRequest request;
  late SharedPreferences prefs;
  Location location = Location();
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void dispose() {
    mapController.dispose();

    super.dispose();
  }

  Future<void> init() async {
    PermissionRequest request = PermissionRequest();
    await request.requestLocationPermission(context);
    //updateLocation();
    prefs = await SharedPreferences.getInstance();
  }

  updateLocation() {
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (mounted) {
        setState(() {
          if (mounted) {
            final latitude = currentLocation.latitude ?? 0.0;
            final longitude = currentLocation.longitude ?? 0.0;
            prefs.setDouble('lat', latitude);
            prefs.setDouble('long', longitude);
            userLocation = LatLng(latitude, longitude);
            CameraPosition cameraPosition = CameraPosition(
              target: userLocation,
              zoom: 18,
            );
            mapController
                .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
          }
        });
      }
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    if (mounted) {
      setState(() {
        if (mounted) {
          mapController = controller;
          updateLocation();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: const CameraPosition(
        target: LatLng(4.6494536, -74.053825), // Initial map center
        zoom: 18.0, // Initial zoom level
      ),
      markers: {
        Marker(
          markerId: const MarkerId('user_location'),
          position: userLocation,
        ),
      },
    );
  }
}
