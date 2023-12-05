import 'package:flutter/material.dart';
import 'package:safe_go_dart/View/DestinationChoiceView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../ViewModel/ManageTrip.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';

class EditTripInfoView extends StatelessWidget {
  final int i;

  const EditTripInfoView(this.i, {Key? key}) : super(key: key);

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
    final controllerSource = TextEditingController();
    final controllerDestination = TextEditingController();
    final screenHeight = MediaQuery.of(context).size.height;
    double heightPadding = screenHeight * 0.04;
    void chargeReportFromMemory() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (prefs.getString('savedReport') != null) {
        controllerSource.text = prefs.getString('savedReport')!;
      }
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
                          padding: const EdgeInsets.only(top: 100.0),
                          child: RichText(
                            text: const TextSpan(
                              text: "Edit trip details\n",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: heightPadding,
                          width: 370.0,
                          color: Colors.transparent,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 52.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: controllerSource,
                                maxLines: 20,
                                onChanged: (text) {
                                  //addReportToMemory(myController.text);
                                },
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  hintText:
                                      'Where do you want to start your trip?',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: heightPadding,
                          width: 370.0,
                          color: Colors.transparent,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 0.0),
                          height: 52.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: controllerDestination,
                                maxLines: 20,
                                onChanged: (text) {
                                  //addReportToMemory(controllerDestination.text);
                                },
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Where do you wan\'t to go?',
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: heightPadding,
                          width: 370.0,
                          color: Colors.transparent,
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
                              final ManageTrip manageTrip = ManageTrip();
                              if (controllerSource.text.isNotEmpty &&
                                  controllerDestination.text.isNotEmpty) {
                                manageTrip.validateAddress(
                                    controllerSource.text,
                                    controllerDestination.text,
                                    i);
                                //deleteReportFromMemory();
                                // Navigator.push(
                                //  context,
                                //  MaterialPageRoute(
                                //   builder: (context) =>
                                //      DestinationChoiceView(),
                                //   ),
                                // );
                                const snackBar = SnackBar(
                                  content: Text('We got your Route!'),
                                  duration: Duration(milliseconds: 2000),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                const snackBar = SnackBar(
                                  content:
                                      Text('Please fill all of the fields'),
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
