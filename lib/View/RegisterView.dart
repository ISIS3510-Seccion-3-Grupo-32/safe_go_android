import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../ViewModel/AuthenticationViewModel.dart';
import 'SafeGoMain.dart';

class RegisterView extends StatefulWidget {
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
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    dobController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double paddingSides = screenWidth * 0.05;
    double paddingBetween = screenHeight * 0.01;
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;
    double paddingBetweenInputs = screenHeight * 0.03;
    double paddingBeforeRegister = screenHeight * 0.09;
    double paddingAfterSubmit = screenHeight * 0.09;
    if (keyboardPadding > 0) {
      paddingBetweenInputs = paddingBetween;
      paddingBeforeRegister = screenHeight * 0.03;
      paddingAfterSubmit = screenHeight * 0.015;
      fontRegister = screenHeight * 0.04;
    }

    return Consumer<AuthenticationViewModel>(
      builder: (context, authenticationViewModel, child) {
        return Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                padding: EdgeInsets.only(top: paddingBeforeRegister),
                decoration: const BoxDecoration(
                  color: Color(0xFF96CEB4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                      child: Center(
                        child: SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      paddingSides,
                                      paddingBetween,
                                      paddingSides,
                                      paddingBetweenInputs),
                                  child: TextFormField(
                                    controller: fullNameController,
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
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintText: "Full Name",
                                      fillColor: Colors.white70,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 12.0),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Full Name is required';
                                      }

                                      final nameParts = value.split(" ");
                                      if (nameParts.length < 2) {
                                        return 'Please provide first and last name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      paddingSides,
                                      paddingBetweenInputs,
                                      paddingSides,
                                      paddingBetweenInputs),
                                  child: TextFormField(
                                    controller: passwordController,
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
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintText: "Password",
                                      fillColor: Colors.white70,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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

                                      List<String> errors = [];

                                      if (value.length < 8) {
                                        errors.add(
                                            'Password must be at least 8 characters long');
                                      }

                                      if (!value.contains(RegExp(r'[a-z]'))) {
                                        errors.add(
                                            'Password must contain at least one lowercase letter');
                                      }

                                      if (!RegExp(r'[A-Z]').hasMatch(value)) {
                                        errors.add(
                                            'Password must contain at least one uppercase letter');
                                      }

                                      if (!RegExp(r'[0-9]').hasMatch(value)) {
                                        errors.add(
                                            'Password must contain at least one number');
                                      }

                                      if (!RegExp(r'[!@#$%^&*]')
                                          .hasMatch(value)) {
                                        errors.add(
                                            'Password must contain at least one special character');
                                      }

                                      if (errors.isNotEmpty) {
                                        return errors.join('\n');
                                      }
                                      return null;
                                    },
                                    obscureText: _obscureText,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      paddingSides,
                                      paddingBetweenInputs,
                                      paddingSides,
                                      paddingBetweenInputs),
                                  child: TextFormField(
                                    controller: emailController,
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
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintText: "Email",
                                      fillColor: Colors.white70,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                  padding: EdgeInsets.fromLTRB(
                                      paddingSides,
                                      paddingBetweenInputs,
                                      paddingSides,
                                      paddingBetween),
                                  child: TextFormField(
                                    controller: dobController,
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
                                      hintStyle:
                                          const TextStyle(color: Colors.grey),
                                      hintText: "Date of birth (MM/DD/YYYY)",
                                      fillColor: Colors.white70,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                      final day =
                                          int.parse(match.group(2) ?? '0');
                                      final year =
                                          int.parse(match.group(3) ?? '0');

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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(paddingSides, paddingBetween,
                          paddingSides, paddingBetween),
                      child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.08,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final email = emailController.text;
                              final password = passwordController.text;
                              final authenticationViewModel =
                                  Provider.of<AuthenticationViewModel>(context,
                                      listen: false);
                              final user = await authenticationViewModel.signUp(
                                  email, password);
                              if (user == null) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Email Already Used'),
                                      content: Text(
                                          'The email address is already in use. Please enter another email or try to log in.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Registration successful'),
                                      content: Text(
                                          'Your account has been successfully created.'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => SafeGo(),
                                              ),
                                            );
                                          },
                                          child: Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
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
                    SizedBox(height: paddingAfterSubmit)
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
