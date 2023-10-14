import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/View/SafeGoMap/MapDecorators.dart';

import '../ViewModel/AuthenticationViewModel.dart';
import 'SafeGoMain.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:intl/intl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  final dateFormat = DateFormat('MM/dd/yyyy');
  bool _obscureText = true;

  final fullNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime currentDate = DateTime(2000, 1, 1);

    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2018),
    );

    if (picked != null) {
      setState(() {
        dobController.text = dateFormat.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double paddingSides = screenWidth * 0.05;
    double paddingBetween = screenHeight * 0.01;

    return ChangeNotifierProvider(
      create: (_) => AuthenticationViewModel(),
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Expanded(
                  flex: 1, // Set the flex factor for the map
                  child: MarkerDecorator(map: SafeGoMap()),
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
                                height: 2.0,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(paddingSides,
                                  paddingBetween, paddingSides, paddingBetween),
                              child: TextFormField(
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
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Full Name",
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.symmetric(
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
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
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
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Email",
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.symmetric(
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
                                controller: dobController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  filled: true,
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  hintText: "Date of birth (MM/DD/YYYY)",
                                  fillColor: Colors.white70,
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  suffixIcon: IconButton(
                                    icon: const Icon(Icons.calendar_today),
                                    onPressed: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Birthdate is required';
                                  }

                                  const datePattern =
                                      r'^(\d{2})/(\d{2})/(\d{4})$';
                                  final match =
                                      RegExp(datePattern).firstMatch(value);

                                  if (match == null) {
                                    return 'Invalid date format. Please use "DD/MM/YYYY".';
                                  }

                                  final month =
                                      int.parse(match.group(1) ?? '0');
                                  final day = int.parse(match.group(2) ?? '0');
                                  final year = int.parse(match.group(3) ?? '0');

                                  if (day < 1 || day > 31) {
                                    return 'Invalid day. Day must be between 1 and 31.';
                                  }
                                  if (month < 1 || month > 12) {
                                    return 'Invalid month. Month must be between 1 and 12.';
                                  }
                                  if (year < 1900 || year > 2018) {
                                    return 'Invalid year. Year must be between 1900 and 2018.';
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
                                    debugPrint(
                                        'Email: ${emailController.text}');
                                    debugPrint(
                                        'Date of Birth: ${dobController.text}');
                                    final authenticationViewModel =
                                        Provider.of<AuthenticationViewModel>(
                                            context,
                                            listen: false);
                                    authenticationViewModel.signUp(
                                        emailController.text,
                                        passwordController.text);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const SafeGo(),
                                      ),
                                    );
                                  }
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
