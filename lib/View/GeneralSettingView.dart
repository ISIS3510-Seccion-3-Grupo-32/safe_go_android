import 'package:flutter/material.dart';
import 'ReportBugsView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'ToggleButton.dart';

class GeneralSettingsView extends StatelessWidget {
  const GeneralSettingsView({super.key});

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
                text: "General Settings",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: fontName,
                ),
              ),
            ),
            SizedBox(height: spaceBetweenLinks),
            ToggleButton()
          ],
        ),
      ),
    );
  }
}
