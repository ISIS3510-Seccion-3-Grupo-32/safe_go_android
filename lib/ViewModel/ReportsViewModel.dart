import 'package:flutter/cupertino.dart';
import '../Model/FirebaseServiceProvider.dart';

class ReportsViewModel extends ChangeNotifier {
  Future<Object?> sendSubjectReport(String Psubject) {
    return sendReportData(Psubject, 'usersReports');
  }

  Future<Object?> sendDetailedReport(String Psubject) {
    return sendDetailedReportData(Psubject, 'detailedUserReports');
  }
}
