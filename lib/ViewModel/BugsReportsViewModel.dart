import 'package:flutter/cupertino.dart';
import '../Service Providers/FirebaseServiceProvider.dart';

class BugsReportsViewModel extends ChangeNotifier {
  Future<Object?> sendBugReport(String category, String report) {
    return sendBugToDatabase(report, category, "bugReports");
  }
}
