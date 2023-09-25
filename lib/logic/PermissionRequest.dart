import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
class PermissionRequest {
  LatLng  userLocation;
  PermissionRequest({Key? key, required this.userLocation});

  requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {

    } else if (status.isDenied) {
    } else if (status.isPermanentlyDenied) {

    }
  }
}