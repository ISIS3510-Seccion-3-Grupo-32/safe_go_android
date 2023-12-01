import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoConnectivityView extends StatelessWidget {
  const NoConnectivityView({super.key});

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

  Future<void> _showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.ncTitle),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    double fontName = screenWidth * 0.07;
    double iconSize = screenWidth * 0.1;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset('assets/images/216x216Logo.png'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  AppLocalizations.of(context)!.ncHeader,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: fontName,
                  ),
                ),
                Icon(
                  Icons.signal_wifi_off,
                  color: Colors.white,
                  size: iconSize,
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: screenWidth * 0.8,
                height: screenHeight * 0.06,
                child: ElevatedButton(
                  onPressed: () async {
                    bool connectionState = await checkConnectivity();

                    if (connectionState) {
                      Navigator.pop(context);
                    } else {
                      _showErrorDialog(
                          context, AppLocalizations.of(context)!.ncPopup);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.ncButton,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
