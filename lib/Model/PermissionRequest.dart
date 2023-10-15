import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionRequest {
  PermissionRequest({Key? key});

  requestLocationPermission(BuildContext context) async {
    var status = await Permission.location.request();
    if (status.isGranted) {
    } else if (status.isDenied) {
      await showPermissionDeniedDialog(context);
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  Future<void> showPermissionDeniedDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Please grant location permission to use SafeGo"),
          content:
              const Text("To use the App, please grant location permission."),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
