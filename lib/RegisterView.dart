import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  // Define TextEditingController instances
  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double fontInputs = screenHeight * 0.04;
    double paddingSides = screenWidth * 0.05;
    double paddingBetween = screenHeight * 0.01;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                flex: 1, // Set the flex factor for the map
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
                  child: Form(
                    key: _formKey,
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
                            child: TextFormField(
                              controller:
                                  fullNameController, // Assign the controller
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Full Name",
                                fillColor: Colors.white70,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Full Name is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(paddingSides,
                                paddingBetween, paddingSides, paddingBetween),
                            child: TextFormField(
                              controller:
                                  passwordController, // Assign the controller
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Password",
                                fillColor: Colors.white70,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is required';
                                }
                                return null;
                              },
                              obscureText: _obscureText,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(paddingSides,
                                paddingBetween, paddingSides, paddingBetween),
                            child: TextFormField(
                              controller:
                                  emailController, // Assign the controller
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Email",
                                fillColor: Colors.white70,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email is required';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(paddingSides,
                                paddingBetween, paddingSides, paddingBetween),
                            child: TextFormField(
                              controller:
                                  dobController, // Assign the controller
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                ),
                                filled: true,
                                hintStyle: TextStyle(color: Colors.grey),
                                hintText: "Date of birth",
                                fillColor: Colors.white70,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 12.0),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Birthdate is required';
                                }
                                return null;
                              },
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
                                if (_formKey.currentState!.validate()) {
                                  // Print the content of the input fields
                                  debugPrint(
                                      'Full Name: ${fullNameController.text}');
                                  debugPrint(
                                      'Password: ${passwordController.text}');
                                  debugPrint('Email: ${emailController.text}');
                                  debugPrint(
                                      'Date of Birth: ${dobController.text}');
                                }
                              },
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
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
