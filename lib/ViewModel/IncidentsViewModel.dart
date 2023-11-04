import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
    print("found$closestReport");
    double closestR = -1.0;
    if(closestReport == null) {

      closestR = await db.queryFirestore('policeReports');
      compute(saveDataInCache,closestR);
      return closestR;
    }
    else
      {
        closestR = closestReport;
      }
    return closestR;
  }
  Future<void> saveDataInCache(double closestR) async
  {
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('closest_report', closestR);
  }
}