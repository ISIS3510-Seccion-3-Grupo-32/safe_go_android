import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:latlong2/latlong.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:safe_go_dart/Model/ManageTripApi.dart';
import 'package:safe_go_dart/Model/TravelData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Model/CacheManager.dart';
import '../Model/LocalSQLDB.dart';
import '../Model/NearIncidents.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:http/http.dart';
class ManageTrip {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;

  GetIt getIt = GetIt.instance;
  retriveAndSave(String address, double lat, double lng, String key) async
  {
    double lat = await getDistanceFromCache("${key}lat");
    double lng = await getDistanceFromCache("${key}lng");
    saveDistanceToCache("${key}lat", lat);
    saveDistanceToCache("${key}lng",lng);
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? userLat = prefs.getDouble('lat');
    double? userLong = prefs.getDouble('long');
    NearIncidents db = NearIncidents();
    saveDistanceToCache("${key}lat", db.calculateDistance(lat, lng,userLat??0,userLong??0));
  }

  Future<void> validateAddress(String addressSource, String addressDestination, int i)
  async {
    List<Object> source = await getLatLong(addressSource);
    List<Object> destination = await getLatLong(addressDestination);
    if (MemoryCache.instance.read<double>('LatS') == null ) {
      MemoryCache.instance.create('LatS', source[0]);
    }
    if (MemoryCache.instance.read<double>('LngS') == null ) {
      MemoryCache.instance.create('LngS', source[1]);
    }
    if (MemoryCache.instance.read<double>('LatD') == null ) {
      MemoryCache.instance.create('LatD', destination[0]);
    }
    if (MemoryCache.instance.read<double>('LngD') == null ) {
      MemoryCache.instance.create('LngD', destination[1]);
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latS', source[0] as double);
    prefs.setDouble('lngS', source[1] as double);
    prefs.setDouble('latD', destination[0] as double);
    prefs.setDouble('lngD', destination[1] as double);

    source[1] as double;
    destination[0] as double;
    destination[1] as double;
    retriveAndSave(source[2] as String, source[0] as double, source[1] as double, "$i-source");
    retriveAndSave(destination[2] as String, destination[0] as double, destination[1] as double, "$i-destination");
    TravelData td = TravelData(i, source[2] as String, destination[2] as String,"");
    print(td);
    getIt<LocalSQLDB>().insertTravelData(td);
    print("Done?");
  }
}