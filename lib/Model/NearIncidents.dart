import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
class NearIncidents {

  Location location = Location();
  LatLng userLocation = LatLng (4.5004536, -74.003825);
  updateLocation() {
    location.onLocationChanged.listen((LocationData currentLocation) {
        final latitude = currentLocation.latitude ?? 0.0;
        final longitude = currentLocation.longitude ?? 0.0;
        userLocation = LatLng(latitude, longitude);

      });
  }
  Future<double> queryFirestore(String collection) async {
    updateLocation();
    FirebaseFirestore db = FirebaseFirestore.instance;
    QuerySnapshot querySnapshot = await db.collection(collection).get();
    var minDistance = double.maxFinite;
    double lat = 0;
    double long = 0;
    double distance = 0;
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      QueryDocumentSnapshot record = querySnapshot.docs[i];
      GeoPoint location = record['Record'];
      lat = location.latitude;
      long = location.longitude;
      distance = calculateDistance(userLocation.latitude, userLocation.longitude, lat, long);
      if (distance < minDistance) {
        minDistance = distance;
      }
    }

    return minDistance;
  }


  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371;
  final double lat1Rad = convertToRadians(lat1);
  final double lon1Rad = convertToRadians(lon1);
  final double lat2Rad = convertToRadians(lat2);
  final double lon2Rad = convertToRadians(lon2);

  final double dLat = lat2Rad - lat1Rad;
  final double dLon = lon2Rad - lon1Rad;
  final double a = pow(sin(dLat / 2), 2) + cos(lat1Rad) * cos(lat2Rad) * pow(sin(dLon / 2), 2);

  final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
  final double distance = earthRadius * c;
  return distance;
  }
  double convertToRadians(double degrees) {
  return degrees * pi / 180.0;
  }
}