import 'package:flutter/cupertino.dart';
import '../Service Providers/FirebaseServiceProvider.dart';

class ReportsViewModel extends ChangeNotifier {
  Future<Object?> sendDetailedReport(String Psubject, String Pcategory) {
    return sendDetailedReportData(Psubject, Pcategory, 'detailedUserReports');
  }
}
