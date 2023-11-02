import 'package:flutter/cupertino.dart';
import '../Model/UpdateClicks.dart';

class ClicksViewModel extends ChangeNotifier {
  Future<Object?> updateClickCount(String docId) {
    return updateClickValue(docId, 'ButtonClicks');
  }
}
