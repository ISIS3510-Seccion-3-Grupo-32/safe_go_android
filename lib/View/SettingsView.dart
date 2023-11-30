import 'package:flutter/material.dart';
import 'ReportBugsView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'GeneralSettingView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

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
    double fontName = screenHeight * 0.05;
    double fontLinks = screenHeight * 0.03;
    double spaceAroundUser = screenHeight * 0.05;
    double spaceBetweenLinks = screenHeight * 0.04;
    double paddingLeftLinks = screenWidth * 0.03;
    double iconSize = screenHeight * 0.04;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true, // Add your title here
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
            SizedBox(height: spaceAroundUser),
            RichText(
              text: TextSpan(
                text: "Gwen",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontName,
                ),
              ),
            ),
            SizedBox(height: spaceAroundUser),
            Container(
              color: Colors.white,
              height: 2.0,
            ),
            SizedBox(height: spaceAroundUser * 2),
            Padding(
              padding: EdgeInsets.only(left: paddingLeftLinks),
              child: GestureDetector(
                onTap: () async {
                  bool connectionState = await checkConnectivity();

                  if (connectionState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GeneralSettingsView(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoConnectivityView(),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.settings,
                      color: Colors.black,
                      size: iconSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: paddingLeftLinks),
                      child: Text(
                        AppLocalizations.of(context)!.settings,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLinks,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spaceBetweenLinks),
            Padding(
              padding: EdgeInsets.only(left: paddingLeftLinks),
              child: GestureDetector(
                onTap: () async {
                  bool connectionState = await checkConnectivity();

                  if (connectionState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsView(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoConnectivityView(),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.help,
                      color: Colors.black,
                      size: iconSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: paddingLeftLinks),
                      child: Text(
                        'PQRS',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLinks,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: spaceBetweenLinks),
            Padding(
              padding: EdgeInsets.only(left: paddingLeftLinks),
              child: GestureDetector(
                onTap: () async {
                  bool connectionState = await checkConnectivity();

                  if (connectionState) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReportBugsView(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NoConnectivityView(),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.black,
                      size: iconSize,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: paddingLeftLinks),
                      child: Text(
                        'Problems within the app',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: fontLinks,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
