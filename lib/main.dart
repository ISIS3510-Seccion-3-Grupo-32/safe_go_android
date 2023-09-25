import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'DestinationChoiceView.dart'; // Import your DestinationChoice widget
import 'RegisterView.dart';
import 'package:safe_go_dart/logic/PermissionRequest.dart';

import 'SafeGoMap.dart';
void main() {
  runApp(const SafeGo());
}

class SafeGo extends StatelessWidget {
  const SafeGo({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const SafeGoMain(title: 'Go Safe Testing'),
    );
  }
}

class SafeGoMain extends StatefulWidget {
  const SafeGoMain({super.key, required this.title});

  final String title;

  @override
  State<SafeGoMain> createState() => _SafeGoMainState();
}

class _SafeGoMainState extends State<SafeGoMain> {
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  LatLng userLocation = LatLng(0.0,0.0);
  @override
  void initState() {
    super.initState();
    PermissionRequest request = PermissionRequest(userLocation: userLocation);
    request.requestLocationPermission();
  }
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double fontSubtext = screenHeight * 0.02;
    double paddingSides = screenWidth * 0.05;

    return Scaffold(
      body: Column(
        children: [
          const Flexible(
            flex: 2,
            child: SafeGoMap(),
          ),
          Flexible(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF96CEB4),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: paddingSides),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: "Welcome to SafeGo",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: fontRegister,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSides),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login Before you start your trip!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSubtext,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSides),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'USER LOCATION DATA GOES HERE!!!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: fontSubtext,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    height: 2.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingSides),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Login Credentials',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSubtext,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: paddingSides),
                        child: TextField(
                          controller: fullNameController,
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
                            hintText: "Username",
                            fillColor: Colors.white70,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: paddingSides),
                    child: TextField(
                      controller: passwordController,
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
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.06,
                      child: ElevatedButton(
                        onPressed: () {
                          // Print the content of the input fields
                          debugPrint('Username: ${fullNameController.text}');
                          debugPrint('Password: ${passwordController.text}');

                          // Redirect to DestinationChoice when the button is clicked
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DestinationChoiceView(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        // Navigate to the registration view
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterView(),
                          ),
                        );
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: fontSubtext,
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: 'Register',
                                style: TextStyle(
                                  color: Colors.black,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
