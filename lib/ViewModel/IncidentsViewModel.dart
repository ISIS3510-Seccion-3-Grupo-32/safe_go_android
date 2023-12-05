import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Model/NearIncidents.dart';

class IncidentsViewModel {
  NearIncidents db = NearIncidents();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  bool connected = true;
   void checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
        connected = true;
      }
       else if (result == ConnectivityResult.none) {
        connected = false;
      }
    });
  }
  Future<double> queryDataBase() async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    double? closestReport = prefs.getDouble('closest_report');
    double closestR = -1.0;
    if(MemoryCache.instance.read<String>('closest_report') != null) {
      return MemoryCache.instance.read<String>('closest_report') as double;
    }
    else if(closestReport == null && connected)
    {
      closestR = await db.queryFirestore('policeReports');
      compute(saveDataInCache,closestR);
      return closestR;
    }
    else
      {
        closestR = closestReport!;
      }
    return closestR;
  }
  Future<void> saveDataInCache(double closestR) async
  {
    saveInformationInCache('closest_report',closestR);
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setDouble('closest_report', closestR);
  }
  Future<void> saveInformationInCache(String name, double value ) async {
     if (MemoryCache.instance.read<String>(name) != null)
    {
      MemoryCache.instance.create(name, value);
    }
  }
}

