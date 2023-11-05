import 'package:flutter/material.dart';
import 'package:safe_go_dart/View/DestinationChoiceView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../ViewModel/ReportsViewModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';

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

    addReportToCache(String textsToBeSabed) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('savedReport', textsToBeSabed);
    }

    void chargeReportFromCache() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('savedReport') != null) {
        myController.text = prefs.getString('savedReport')!;
      }
    }

    void deleteReportFromCache() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('savedReport');
    }

    Future<String> categorizeDetailedReport(String inputText) async {
      final url = Uri.parse(
          "https://us-central1-safego-399621.cloudfunctions.net/classify-report");
      final headers = {"Content-Type": "application/json"};
      final body = {"input_text": inputText};
      String responseString = "crime";
      final response =
          await http.post(url, headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        responseString = data["Category"];

        print("Response as a string: $responseString");
      } else {
        print("Failed to connect to the backend");
      }
      return responseString;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      chargeReportFromCache();
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
                            text: const TextSpan(
                              text: "Report Suspicious Activity\n",
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
                            text: const TextSpan(
                              text: "Tell us more about what happened",
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
                                  addReportToCache(myController.text);
                                },
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Write your Detailed Report Here',
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
                          child: const Text(
                            "Submit",
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
                                String reportCategory =
                                    await categorizeDetailedReport(
                                        myController.text);
                                report.sendDetailedReport(
                                    myController.text, reportCategory);
                                deleteReportFromCache();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DestinationChoiceView(),
                                  ),
                                );
                                const snackBar = SnackBar(
                                  content: Text('We got your Report!'),
                                  duration: Duration(milliseconds: 2000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Please tell us more about this situation'),
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
