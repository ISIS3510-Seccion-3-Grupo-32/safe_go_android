import 'package:flutter/cupertino.dart';
import '../Model/UpdateClicks.dart';

class ReportsViewModel extends ChangeNotifier {
  Future<Object?> sendSubjectReport(String docId) {
    return updateClickValue(docId, 'ButtonClicks');
  }
}
