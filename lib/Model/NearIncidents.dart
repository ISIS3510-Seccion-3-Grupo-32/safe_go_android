import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
class NearIncidents {
  LatLng userLocation = LatLng (4.5494536, -74.003825);

  Future<double> queryFirestore(String collection) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await db.collection(collection).get();
  print(querySnapshot);
  var minDistance = double.maxFinite;
  for (QueryDocumentSnapshot record in querySnapshot.docs) {
    GeoPoint location = record['Report'];
    double lat = location.latitude;
    double long = location.longitude;
    double distance = calculateDistance(userLocation.latitude, userLocation.longitude, lat, long);
    print(distance);
    if(distance < minDistance) {
      minDistance = distance;
    }
  }
  print(minDistance);
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