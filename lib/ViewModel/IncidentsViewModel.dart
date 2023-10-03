import 'package:flutter/cupertino.dart';
import '../Model/NearIncidents.dart';

class IncidentsViewModel {
  NearIncidents db = NearIncidents();
  Future<double> queryDataBase() {
    return db.queryFirestore('policeReports');
  }
}