import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/ViewModel/AuthenticationViewModel.dart';
import 'DestinationChoiceView.dart'; // Import your DestinationChoice widget
import 'RegisterView.dart';
import 'SafeGoMap/MapDecorators.dart';
import 'SafeGoMap/SafeGoMap.dart';
import '../ViewModel/IncidentsViewModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCb1qShGeUAk0G4La6deQ8AJ5pmziwPMbY",
          appId: "1:7660014008:android:e60068ab4b28fba38ee74d",
          messagingSenderId: "7660014008",
          projectId: "safego-399621"));
  runApp(const SafeGo());
}

class SafeGo extends StatelessWidget {
  const SafeGo({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthenticationViewModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const SafeGoMain(title: 'Go Safe Testing'),
      ),
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
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final IncidentsViewModel incidents = IncidentsViewModel();
  String TotalIncidents = '0';
  @override
  void initState() {
    super.initState();
    _fetchTotalIncidents();
  }

  Future<void> _fetchTotalIncidents() async {
    try {
      double totalIncidents = await incidents.queryDataBase();
      setState(() {
        TotalIncidents = (totalIncidents * 1000).toStringAsFixed(2);
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
          title: Text('Authentication Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
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

    return Scaffold(
      body: Column(
        children: [
          const Flexible(
            flex: 2,
            child: MarkerDecorator(
              map: SafeGoMap(),
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
                        'Be careful, the closest incident was located $TotalIncidents meters from you!',
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
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
                          padding:
                              EdgeInsets.symmetric(horizontal: paddingSides),
                          child: TextFormField(
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

                              if (value.length < 8 ||
                                  !value.contains(RegExp(r'[a-z]')) ||
                                  !RegExp(r'[A-Z]').hasMatch(value) ||
                                  !RegExp(r'[0-9]').hasMatch(value) ||
                                  !RegExp(r'[!@#$%^&*]').hasMatch(value)) {
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
                                if (_formKey.currentState!.validate()) {
                                  final authenticationViewModel =
                                      Provider.of<AuthenticationViewModel>(
                                          context,
                                          listen: false);

                                  // Call the signIn method
                                  final user =
                                      await authenticationViewModel.signIn(
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
                                  builder: (context) => const RegisterView(),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
