import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:safe_go_dart/Model/ManageTrip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/CacheManager.dart';
import '../Model/NearIncidents.dart';
class ManageTrip {

  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  retriveAndSave(String address, String key) async
  {
    double lat = await getDistanceFromCache("${key}lat");
    double lng = await getDistanceFromCache("${key}lng");
    if (lat == 0.0 || lng == 0.0) {
      LatLng location = await getLatLong(address);
      saveDistanceToCache("${key}lat", location.latitude);
      saveDistanceToCache("${key}lat", location.longitude);
    }
    else {

    }
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? userLat = prefs.getDouble('lat');
    double? userLong = prefs.getDouble('long');
    NearIncidents db = NearIncidents();
    saveDistanceToCache("${key}lat", db.calculateDistance(lat, lng,userLat??0,userLong??0));
  }
}