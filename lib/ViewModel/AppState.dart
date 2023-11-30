import 'package:flutter/cupertino.dart';

class AppState extends ChangeNotifier {
  Locale _appLocale = Locale('en');

  Locale get appLocale => _appLocale;

  void setLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }
}
