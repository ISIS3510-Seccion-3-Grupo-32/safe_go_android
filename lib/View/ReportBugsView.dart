import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart'; // Ensure that your import paths are correct.
import 'DestinationChoiceView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../ViewModel/BugsReportsViewModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';

class ReportBugsView extends StatelessWidget {
  ReportBugsView({Key? key}) : super(key: key); // Fix the constructor syntax.

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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

  Future<String> sendInputToBackend(String inputText) async {
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
    double paddingSides = screenWidth * 0.05;
    double sizeBoxPadding = screenHeight * 0.04;
    double fontHeader = screenHeight * 0.04;

    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

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
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: keyboardPadding == 0,
                          child: Text(
                            "Describe your problem",
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              paddingSides, 0, paddingSides, 0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: Colors.grey,
                                ),
                              ),
                              filled: true,
                              hintStyle: const TextStyle(color: Colors.grey),
                              hintText: "When I click on ...",
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 12.0,
                              ),
                            ),
                            maxLines: 7,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please fill the text input';
                              }

                              if (value.length > 50) {
                                return "Text shouldn't be larger than 50 characters";
                              }
                              return null;
                            },
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () async {
                                bool connectionState =
                                    await checkConnectivity();

                                if (connectionState) {
                                  if (_formKey.currentState!.validate()) {
                                    print(emailController.text);

                                    String category = await sendInputToBackend(
                                        emailController.text);
                                    print("Category : ");
                                    print(category);
                                    BugsReportsViewModel report =
                                        BugsReportsViewModel();
                                    report.sendBugReport(
                                        category, emailController.text);
                                    _showErrorDialog(
                                      context,
                                      "Your problem description has been successfully sent. Thank you for helping improve the app.",
                                    );
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                              ),
                              child: const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
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
