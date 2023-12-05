import 'package:flutter/cupertino.dart';
import '../Service Providers/FirebaseServiceProvider.dart';

class ReportsController extends ChangeNotifier {
  Future<Object?> sendDetailedReport(String Psubject) {
    return sendDetailedReportDataToBack(Psubject, 'detailedUserReports');
  }

  Future<Object?> sendUserRegistrationLocation(String Psubject) {
    return sendDetailedReportDataToBack(Psubject, 'userLoginInfo');
  }
}
