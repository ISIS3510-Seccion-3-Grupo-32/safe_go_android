import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart'; // Ensure that your import paths are correct.
import '../ViewModel/ReportsViewModel.dart';
import 'DestinationChoiceView.dart';
import 'RegisterView.dart'; // Import the RegisterView if it's not imported.

class ReportBugsView extends StatelessWidget {
  ReportBugsView({Key? key}) : super(key: key); // Fix the constructor syntax.

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DestinationChoiceView(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

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
                                if (_formKey.currentState!.validate()) {
                                  _showErrorDialog(
                                    context,
                                    "Your problem description has been successfully sent. Thank you for helping improve the app.",
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
