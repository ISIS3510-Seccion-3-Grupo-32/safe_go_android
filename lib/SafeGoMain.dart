import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'DestinationChoiceView.dart'; // Import your DestinationChoice widget
import 'RegisterView.dart';

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
  final _formKey = GlobalKey<FormState>();

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
          Flexible(
            flex: 2,
            child: FlutterMap(
              options: MapOptions(
                interactiveFlags: InteractiveFlag.none,
                center: LatLng(4.60140465, -74.0649032880709),
                zoom: 18.0,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
              ],
            ),
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
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: paddingSides),
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
                          padding:
                              EdgeInsets.symmetric(horizontal: paddingSides),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Username',
                              hintText: 'Enter your username',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username is required';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: paddingSides),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Enter your password',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
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
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Print the content of the input fields
                                  debugPrint(
                                      'Username: ${fullNameController.text}');
                                  debugPrint(
                                      'Password: ${passwordController.text}');

                                  // Redirect to DestinationChoice when the button is clicked
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DestinationChoiceView(),
                                    ),
                                  );
                                }
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
                                  children: <TextSpan>[
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
