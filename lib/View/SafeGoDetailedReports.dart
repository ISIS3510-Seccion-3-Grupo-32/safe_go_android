import 'package:flutter/material.dart';
import 'package:safe_go_dart/View/DestinationChoiceView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Controllers/ReportsController.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SafeGoDetailedReports extends StatelessWidget {
  const SafeGoDetailedReports({
    super.key,
  });

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
    final myController = TextEditingController();

    addReportToMemory(String textsToBeSabed) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('savedReport', textsToBeSabed);
    }

    void chargeReportFromMemory() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('savedReport') != null) {
        myController.text = prefs.getString('savedReport')!;
      }
    }

    void deleteReportFromMemory() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('savedReport');
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      chargeReportFromMemory();
    });
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1, // Set the flex factor for the map
                child: SafeGoMap(),
              ),
              Expanded(
                flex: 1, // Set the flex factor for the registration container
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF96CEB4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RichText(
                            text: TextSpan(
                              text: AppLocalizations.of(context)!.drHeader,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: RichText(
                            text: TextSpan(
                              text: AppLocalizations.of(context)!.drH2,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 52.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: myController,
                                maxLines: 20,
                                onChanged: (text) {
                                  addReportToMemory(myController.text);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  hintText:
                                      AppLocalizations.of(context)!.drHint,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                                99, 165, 136, 1), // Background color
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.registerSubmitButton,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.left,
                          ),
                          onPressed: () async {
                            bool connectionState = await checkConnectivity();
                            if (connectionState) {
                              final ReportsViewModel report =
                                  ReportsViewModel();
                              if (myController.text.isNotEmpty &&
                                  myController.text.characters.length > 20) {
                                report.sendDetailedReport(myController.text);
                                deleteReportFromMemory();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DestinationChoiceView(),
                                  ),
                                );
                                final snackBar = SnackBar(
                                  content: Text(
                                      AppLocalizations.of(context)!.drSnack1),
                                  duration: Duration(milliseconds: 2000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  content: Text(
                                      AppLocalizations.of(context)!.drSnack2),
                                  duration: Duration(milliseconds: 2000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const NoConnectivityView(),
                                ),
                              );
                            }
                          },
                        )
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
