import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  late Locale _appLocale;
  late bool _appDarkMode;
  late bool _appNotifications;
  late double _appSound;
  String _userId = "";

  Locale get appLocale => _appLocale;
  bool get appDarkMode => _appDarkMode;
  bool get appNotifications => _appNotifications;
  double get appSound => _appSound;
  String get userId => _userId;

  AppState() {
    _init();
  }

  Future<void> _init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLocale = prefs.getString('appLocale');
    _appLocale = savedLocale != null ? Locale(savedLocale) : const Locale('en');
    _appDarkMode = prefs.getBool('appDarkMode') ?? false;
    _appNotifications = prefs.getBool('appNotifications') ?? false;
    _appSound = prefs.getDouble('appSound') ?? 0;

    notifyListeners();
  }

  void setLocale(Locale locale) {
    _appLocale = locale;
    notifyListeners();
  }

  void setDarkMode(bool isDarkMode) {
    _appDarkMode = isDarkMode;
    notifyListeners();
  }

  void setNotifications(bool isNotif) {
    _appNotifications = isNotif;
    notifyListeners();
  }

  void setSound(double sound) {
    _appSound = sound;
    notifyListeners();
  }

  void setUserId(String id) {
    _userId = id;
  }
}
