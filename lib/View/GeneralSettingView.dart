import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import '../Model/Globals.dart' as globals;
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/ViewModel/AppState.dart';

const List<Widget> languages = <Widget>[
  Text('English'),
  Text('Español'),
  Text('Français')
];

List<bool> currentLanguage() {
  if (globals.language == 'en') {
    return <bool>[true, false, false];
  } else if (globals.language == 'es') {
    return <bool>[false, true, false];
  } else if (globals.language == 'fr') {
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
  bool isDarkModeActive = globals.isDarkMode;
  bool isNotificationsActive = globals.isNotificationOn;
  double _currentSliderValue = globals.sound;
  final List<bool> _selectedLanguage = currentLanguage();

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
                  value: isDarkModeActive,
                  activeColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      isDarkModeActive = value;
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
                  value: isNotificationsActive,
                  activeColor: Colors.white,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationsActive = value;
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
                  // The button that is tapped is set to true, and the others to false.
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

                globals.setDarkMode(isDarkModeActive);
                globals.setNotification(isNotificationsActive);
                final stateManager =
                    Provider.of<AppState>(context, listen: false);
                if (_selectedLanguage[0] == true) {
                  globals.setLanguage('en');
                  stateManager.setLocale(Locale('en'));
                } else if (_selectedLanguage[1] == true) {
                  globals.setLanguage('es');
                  stateManager.setLocale(Locale('es'));
                } else if (_selectedLanguage[2] == true) {
                  globals.setLanguage('fr');
                  stateManager.setLocale(Locale('fr'));
                }

                globals.setSound(_currentSliderValue);

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
