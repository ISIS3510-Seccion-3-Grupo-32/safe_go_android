import 'package:flutter/cupertino.dart';
import '../Model/NearIncidents.dart';

class IncidentsViewModel extends ChangeNotifier {

  Future<int> queryDataBase() {
    return queryFirestore('policeReports');
  }
}