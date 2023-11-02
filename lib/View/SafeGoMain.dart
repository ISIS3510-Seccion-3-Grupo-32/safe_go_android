import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/ViewModel/AuthenticationViewModel.dart';
import 'DestinationChoiceView.dart';
import 'RegisterView.dart';
import 'SafeGoMap/MapDecorators.dart';
import 'SafeGoMap/SafeGoMap.dart';
import '../ViewModel/IncidentsViewModel.dart';
import 'package:flutter_offline/flutter_offline.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCb1qShGeUAk0G4La6deQ8AJ5pmziwPMbY",
          appId: "1:7660014008:android:e60068ab4b28fba38ee74d",
          messagingSenderId: "7660014008",
          projectId: "safego-399621"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationViewModel()),
        // Other providers if needed
      ],
      child: SafeGo(),
    ),
  );
}

class SafeGo extends StatelessWidget {
  final AuthenticationViewModel authViewModel = AuthenticationViewModel();
  SafeGo({super.key});

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
  final String title;

  const SafeGoMain({super.key, required this.title});

  @override
  State<SafeGoMain> createState() => _SafeGoMainState();
}

class _SafeGoMainState extends State<SafeGoMain> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final IncidentsViewModel incidents = IncidentsViewModel();
  String TotalIncidents = '0';
  late Timer timer;
  @override
  void initState() {
    super.initState();
    _fetchTotalIncidents();
  }

  Future<void> _fetchTotalIncidents() async {
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (timer)
      async {
        double totalIncidents = await incidents.queryDataBase();
      setState(()  {
        TotalIncidents = (totalIncidents * 1000).toStringAsFixed(2);
      });
      });
    } catch (e) {
      // Handle errors or exceptions if needed
      print('Error fetching total incidents: $e');
    }
  }

  Future<void> _showErrorDialog(
      BuildContext context, String errorMessage) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Authentication Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double fontSubtext = screenHeight * 0.02;
    double paddingSides = screenWidth * 0.05;
    double padding18 = screenWidth * 0.04;
    double padding20 = screenWidth * 0.05;
    int sizeOfMap = 2;
    int sizeOfInputs = 3;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardPadding > 0) {
      sizeOfMap = 1;
      sizeOfInputs = 2;
      fontRegister = screenHeight * 0.04;
      padding20 = screenWidth * 0.04;
      padding18 = screenWidth * 0.03;
    }
    return Consumer<AuthenticationViewModel>(
      builder: (context, authViewModel, child) {
        return Scaffold(
          body: Column(
            children: [
              Flexible(
                flex: sizeOfMap,
                child: OfflineBuilder(
                    connectivityBuilder: (
                        BuildContext context,
                        ConnectivityResult connectivity,
                        Widget child,
                    ){
                      final bool connected = connectivity != ConnectivityResult.none;
                      return connected
                          ? child // Display your online content
                          : const Center(
                        child: Text('No Internet Connection'), // Display an offline message
                      );

                    },
                    child: const MarkerDecorator(
                    map: SafeGoMap(),
          ),

              ),
              ),
              Flexible(
                flex: sizeOfInputs,
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
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: padding20,
                                            horizontal: paddingSides),
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
                                      Visibility(
                                        visible: keyboardPadding == 0,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: paddingSides),
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
                                      ),
                                      Visibility(
                                        visible: keyboardPadding == 0,
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              paddingSides,
                                              0,
                                              paddingSides,
                                              padding20),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              'Be careful, the closest incident was located $TotalIncidents meters from you!',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontSubtext,
                                              ),
                                            ),
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
                                            paddingSides, 10, paddingSides, 0),
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
                                        padding: EdgeInsets.fromLTRB(
                                            paddingSides, 10, paddingSides, 0),
                                        child: TextFormField(
                                          controller:
                                              emailController, // Assign the controller
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText: "Email",
                                            fillColor: Colors.white70,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 12.0),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Email is required';
                                            }
                                            final emailRegex = RegExp(
                                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                                            if (!emailRegex.hasMatch(value)) {
                                              return 'Please enter a valid email address';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: paddingSides,
                                            vertical: padding20),
                                        child: TextFormField(
                                          controller:
                                              passwordController, // Assign the controller
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              borderSide: const BorderSide(
                                                width: 2,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            filled: true,
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText: "Password",
                                            fillColor: Colors.white70,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 12.0),
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password is required';
                                            }

                                            if (value.length < 8 ||
                                                !value.contains(
                                                    RegExp(r'[a-z]')) ||
                                                !RegExp(r'[A-Z]')
                                                    .hasMatch(value) ||
                                                !RegExp(r'[0-9]')
                                                    .hasMatch(value) ||
                                                !RegExp(r'[!@#$%^&*]')
                                                    .hasMatch(value)) {
                                              return 'Passwords must be at least 8 characters long and contain at least one small and one capital letter, one number and one symbol';
                                            }

                                            return null;
                                          },

                                          obscureText: _obscureText,
                                        ),
                                      ),
                                      Center(
                                        child: SizedBox(
                                          width: screenWidth * 0.8,
                                          height: screenHeight * 0.06,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                final authenticationViewModel =
                                                    Provider.of<
                                                            AuthenticationViewModel>(
                                                        context,
                                                        listen: false);

                                                // Call the signIn method
                                                final user =
                                                    await authenticationViewModel
                                                        .signIn(
                                                  emailController.text,
                                                  passwordController.text,
                                                );

                                                if (user != null) {
                                                  // Authentication successful, navigate to the other view
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          DestinationChoiceView(),
                                                    ),
                                                  );
                                                } else {
                                                  // Authentication failed, show error dialog
                                                  _showErrorDialog(context,
                                                      'Authentication failed. Please check your credentials.');
                                                }
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: const Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15),
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
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: padding20),
                              ],
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
      },
    );
  }
}
