import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/ViewModel/AppState.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<Widget> languages = <Widget>[
  Text('English'),
  Text('Español'),
  Text('Français')
];

List<bool> currentLanguage(AppState stateManager) {
  if (stateManager.appLocale == const Locale('en')) {
    return <bool>[true, false, false];
  } else if (stateManager.appLocale == const Locale('es')) {
    return <bool>[false, true, false];
  } else if (stateManager.appLocale == const Locale('fr')) {
    return <bool>[false, false, true];
  }
  return <bool>[true, false, false];
}

class GeneralSettingsView extends StatefulWidget {
  const GeneralSettingsView({super.key});

  @override
  State<GeneralSettingsView> createState() => _GeneralSettingsState();
}

class _GeneralSettingsState extends State<GeneralSettingsView> {
  late bool _isDarkModeActive;
  late bool _isNotificationsActive;
  late double _currentSliderValue;
  late List<bool> _selectedLanguage;

  @override
  void initState() {
    super.initState();
    final stateManager = Provider.of<AppState>(context, listen: false);
    _isDarkModeActive = stateManager.appDarkMode;
    _isNotificationsActive = stateManager.appNotifications;
    _currentSliderValue = stateManager.appSound;
    _selectedLanguage = currentLanguage(stateManager);
  }

  void savePreferences(AppState stateMan) async {
    stateMan.setDarkMode(_isDarkModeActive);
    stateMan.setNotifications(_isNotificationsActive);
    stateMan.setSound(_currentSliderValue);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('appDarkMode', _isDarkModeActive);
    prefs.setBool('appNotifications', _isNotificationsActive);
    prefs.setDouble('appSound', _currentSliderValue);
    if (_selectedLanguage[0] == true) {
      prefs.setString('appLocale', 'en');
      stateMan.setLocale(const Locale('en'));
    } else if (_selectedLanguage[1] == true) {
      stateMan.setLocale(const Locale('es'));
    } else if (_selectedLanguage[2] == true) {
      stateMan.setLocale(const Locale('fr'));
    }
  }

  Future<bool> checkConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.other) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double fontName = screenWidth * 0.08;
    double fontSubtextes = screenWidth * 0.06;
    double spaceBetweenSettings = screenHeight * 0.07;
    double paddingForSwitch = screenWidth * 0.1;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF96CEB4),
        ),
        child: Column(
          children: [
            SizedBox(height: spaceBetweenSettings),
            RichText(
              text: TextSpan(
                text: AppLocalizations.of(context)!.gsvTitle,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontName,
                ),
              ),
            ),
            SizedBox(height: spaceBetweenSettings),
            Row(
              children: [
                SizedBox(
                  width: paddingForSwitch,
                ),
                Expanded(
                  child: Text(AppLocalizations.of(context)!.gsvDark,
                      style: TextStyle(
                        fontSize: fontSubtextes,
                        color: Colors.white,
                      )),
                ),
                Switch(
                  value: _isDarkModeActive,
                  activeColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      _isDarkModeActive = value;
                    });
                  },
                ),
                SizedBox(
                  width: paddingForSwitch,
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(
                  width: paddingForSwitch,
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.gsvNotifications,
                    style: TextStyle(
                      fontSize: fontSubtextes,
                      color: Colors.white,
                    ),
                  ),
                ),
                Switch(
                  value: _isNotificationsActive,
                  activeColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      _isNotificationsActive = value;
                    });
                  },
                ),
                SizedBox(
                  width: paddingForSwitch,
                ),
              ],
            ),
            SizedBox(height: spaceBetweenSettings),
            Text(AppLocalizations.of(context)!.gsvSound,
                style: TextStyle(
                  fontSize: fontSubtextes,
                  color: Colors.white,
                )),
            Slider(
              value: _currentSliderValue,
              max: 100,
              divisions: 5,
              label: _currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _currentSliderValue = value;
                });
              },
            ),
            SizedBox(height: spaceBetweenSettings),
            Text(AppLocalizations.of(context)!.gsvLanguage,
                style: TextStyle(
                  fontSize: fontSubtextes,
                  color: Colors.white,
                )),
            ToggleButtons(
              direction: Axis.horizontal,
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < _selectedLanguage.length; i++) {
                    _selectedLanguage[i] = i == index;
                  }
                });
              },
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              selectedBorderColor: Colors.grey,
              selectedColor: Colors.black,
              fillColor: Colors.white,
              color: Colors.black,
              constraints: const BoxConstraints(
                minHeight: 40.0,
                minWidth: 100.0,
              ),
              isSelected: _selectedLanguage,
              children: languages,
            ),
            SizedBox(height: spaceBetweenSettings),
            ElevatedButton(
              onPressed: () async {
                bool connectionState = await checkConnectivity();
                final stateManager =
                    Provider.of<AppState>(context, listen: false);
                savePreferences(stateManager);

                if (connectionState) {
                  // Authentication successful, navigate to the other view
                  Navigator.pop(context);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NoConnectivityView(),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
              child: Text(
                AppLocalizations.of(context)!.gsvSave,
                style: TextStyle(color: Colors.black, fontSize: fontSubtextes),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
