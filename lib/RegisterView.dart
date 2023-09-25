import 'package:flutter/material.dart';

import 'SafeGoMap.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double paddingSides = screenWidth * 0.05;
    double paddingBetween = screenHeight * 0.01;

    // Define TextEditingController instances
    final fullNameController = TextEditingController();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final dobController = TextEditingController();

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
                flex: 2, // Set the flex factor for the registration container
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF96CEB4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Register",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontRegister,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, paddingBetween, 0, paddingBetween),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.white,
                            height:
                                2.0, // Adjust the height of the Divider line as needed
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(paddingSides,
                              paddingBetween, paddingSides, paddingBetween),
                          child: TextField(
                            controller:
                                fullNameController, // Assign the controller
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
                              hintText: "Full Name",
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(paddingSides,
                              paddingBetween, paddingSides, paddingBetween),
                          child: TextField(
                            controller:
                                passwordController, // Assign the controller
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
                              hintText: "Password",
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(paddingSides,
                              paddingBetween, paddingSides, paddingBetween),
                          child: TextField(
                            controller:
                                emailController, // Assign the controller
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
                              hintText: "Email",
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(paddingSides,
                              paddingBetween, paddingSides, paddingBetween),
                          child: TextField(
                            controller: dobController, // Assign the controller
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
                              hintText: "Date of birth",
                              fillColor: Colors.white70,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 12.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(paddingSides,
                            paddingBetween, paddingSides, paddingBetween),
                        child: SizedBox(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.06,
                          child: ElevatedButton(
                            onPressed: () {
                              // Print the content of the input fields
                              debugPrint(
                                  'Full Name: ${fullNameController.text}');
                              debugPrint(
                                  'Password: ${passwordController.text}');
                              debugPrint('Email: ${emailController.text}');
                              debugPrint(
                                  'Date of Birth: ${dobController.text}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
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
