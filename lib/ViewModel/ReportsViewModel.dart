import 'package:flutter/cupertino.dart';
import '../Model/NearIncidents.dart';
import '../Model/reportDeliverSubsistem.dart';

class ReportsViewModel extends ChangeNotifier {
  Future<Object?> sendSubjectReport(String Psubject) {
    return sendReportData(Psubject, 'usersReports');
  }
}
