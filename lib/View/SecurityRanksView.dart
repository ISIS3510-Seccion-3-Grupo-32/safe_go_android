import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart'; // Ensure that your import paths are correct.
import 'DestinationChoiceView.dart';
import 'select_destination_buttons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/ViewModel/AuthenticationViewModel.dart';
import 'RegisterView.dart';
import 'SafeGoMap/MapDecorators.dart';
import 'package:safe_go_dart/Service Providers/FirebaseServiceProvider.dart';
import '../ViewModel/IncidentsViewModel.dart';
import '../ViewModel/ClicksViewModel.dart';

class SecurityRanksView extends StatelessWidget {
  const SecurityRanksView({super.key});

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

  Future<String> getInfoFromBackEnd(String inputText) async {
    final url = Uri.parse(
        "https://us-central1-safego-399621.cloudfunctions.net/classify-bugs");
    final headers = {"Content-Type": "application/json"};
    final body = {"input_text": inputText};
    String responseString = "crashes";
    final response =
        await http.post(url, headers: headers, body: jsonEncode(body));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      responseString = data["category"];
      // Do something with the category (e.g., display it in your app)

      // Save the response as a string
      print("Response as a string: $responseString");
    } else {
      print("Failed to connect to the backend");
    }
    return responseString;
  }

  Future<void> _showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Message Sent'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                bool connectionState = await checkConnectivity();

                if (connectionState) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DestinationChoiceView(),
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
            ),
          ],
        );
      },
    );
  }

  // Future<void> sendInputToBackend(String inputText) async {
  //   final client = http.Client();
  //   final url = Uri.parse('http://localhost:3001/process_sentence');
  //   final response = await client.post(url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({"input_text": inputText}));

  //   if (response.statusCode == 111) {
  //     print("Fuck off");
  //   }

  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     String category = data["category"];
  //     print("Category from backend: $category");
  //     // Do something with the category (e.g., display it in your app)
  //   } else {
  //     print("Failed to connect to the backend");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    String mostFeloniesNeightboor = "";
    double fontHeader = screenHeight * 0.04;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    Future<void> _fetchTheMostFelonyHood() async {
      if (MemoryCache.instance.read<String>('Felonyhodd') == null ||
          mostFeloniesNeightboor == "") {
        String newPlacerNeightFelony = await getMostFeloniesHood();
        MemoryCache.instance.create('Felonyhodd', newPlacerNeightFelony);
      } else {
        if (mostFeloniesNeightboor != await getMostFeloniesHood()) {
          String newPlacerNeightFelony = await getMostFeloniesHood();
          mostFeloniesNeightboor = newPlacerNeightFelony;
        } else {
          mostFeloniesNeightboor =
              MemoryCache.instance.read<String>('Felonyhodd')!;
        }
      }
    }

    _fetchTheMostFelonyHood();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 2,
                child: SafeGoMap(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF96CEB4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: keyboardPadding == 0,
                          child: Text(
                            "Security Ranks",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: fontHeader,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: keyboardPadding == 0,
                          child: Container(
                            color: Colors.white,
                            height: 2.0,
                          ),
                        ),
                        DirectionButton(
                          onPressed: () async {
                            bool connectionState = await checkConnectivity();
                            if (connectionState) {
                              var snackBar = SnackBar(
                                content: Text(
                                    'The Neighborhood With Reports its Felonies is $mostFeloniesNeightboor'),
                                duration: Duration(milliseconds: 2000),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
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
                          icon: Icons.bus_alert_sharp,
                          label: 'Neighborhood With Most Felonies',
                        ),
                        DirectionButton(
                          onPressed: () async {
                            bool connectionState = await checkConnectivity();
                            if (connectionState) {
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
                          icon: Icons.bus_alert_sharp,
                          label: 'Neighborhood With Most Reports',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
