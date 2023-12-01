import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:memory_cache/memory_cache.dart';
import 'package:provider/provider.dart';
import 'package:safe_go_dart/View/NoConnectivityView.dart';
import 'package:safe_go_dart/ViewModel/AuthenticationViewModel.dart';
import 'package:safe_go_dart/ViewModel/AppState.dart';
import '../Model/LocalSQLDB.dart';
import 'DestinationChoiceView.dart';
import 'RegisterView.dart';
import 'SafeGoMap/MapDecorators.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'package:safe_go_dart/Service Providers/FirebaseServiceProvider.dart';
import '../ViewModel/IncidentsViewModel.dart';
import '../ViewModel/ClicksViewModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../ViewModel/ManageTrip.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<LocalSQLDB>(LocalSQLDB(), signalsReady: true);
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCb1qShGeUAk0G4La6deQ8AJ5pmziwPMbY",
          appId: "1:7660014008:android:e60068ab4b28fba38ee74d",
          messagingSenderId: "7660014008",
          projectId: "safego-399621"));

  final appState = AppState();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appState),
        ChangeNotifierProvider(create: (_) => AuthenticationViewModel()),
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
    return Consumer<AppState>(
      builder: (context, appState, child) {
        return MaterialApp(
          locale: appState.appLocale,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            Locale('en'),
            Locale('es'),
            Locale('fr'),
          ],
          title: "Go Safe Testing",
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),
          home: const SafeGoMain(title: "Safe Go"),
        );
      },
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
  String mostFeloniesNeightboor = "";
  String mostReportedHood = "";
  late Timer timer;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getIt.get<LocalSQLDB>().init();
    super.initState();
    _fetchTotalIncidents();
    _fetchTheMostFelonyHood();
    _fetchTheMostReportedHood();
  }

  Future<void> _fetchTheMostFelonyHood() async {
    MemoryCache.instance.create('Felonyhodd', await getMostFeloniesHood());
    if (MemoryCache.instance.read<String>('Felonyhodd') == null ||
        mostFeloniesNeightboor == "") {
      String newPlacerNeightFelony = await getMostFeloniesHood();

      setState(() {
        if (mounted) {
          mostFeloniesNeightboor = newPlacerNeightFelony;
        }
      });
    } else {
      if (mostFeloniesNeightboor != await getMostFeloniesHood()) {
        String newPlacerNeightFelony = await getMostFeloniesHood();
        setState(() {
          if (mounted) {
            mostFeloniesNeightboor = newPlacerNeightFelony;
          }
        });
      } else {
        setState(() {
          if (mounted) {
            mostFeloniesNeightboor =
                MemoryCache.instance.read<String>('Felonyhodd')!;
          }
        });
      }
    }
  }

  Future<void> _fetchTheMostReportedHood() async {
    MemoryCache.instance.create('ReportedHood', await getMostReportedHood());
    if (MemoryCache.instance.read<String>('ReportedHood') == null ||
        mostReportedHood == "") {
      String newPlacerReportedhood = await getMostReportedHood();

      setState(() {
        if (mounted) {
          mostReportedHood = newPlacerReportedhood;
        }
      });
    } else {
      if (mostReportedHood != await getMostReportedHood()) {
        String newPlacerReportedhood = await getMostReportedHood();
        setState(() {
          if (mounted) {
            mostReportedHood = newPlacerReportedhood;
          }
        });
      } else {
        setState(() {
          if (mounted) {
            mostReportedHood =
                MemoryCache.instance.read<String>('ReportedHood')!;
          }
        });
      }
    }
  }

  Future<void> _fetchTotalIncidents() async {
    try {
      timer = Timer.periodic(const Duration(seconds: 5), (timer) async {
        double totalIncidents = await incidents.queryDataBase();

        setState(() {
          if (mounted) {
            TotalIncidents = (totalIncidents).toStringAsFixed(2);
          }
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
          title: Text(AppLocalizations.of(context)!.mainAuthErrorTitle),
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

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double fontSubtext = screenHeight * 0.02;
    double fontSmall = screenHeight * 0.015;
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
                child: const MarkerDecorator(
                  map: SafeGoMap(),
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
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .mainHeader,
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
                                              AppLocalizations.of(context)!
                                                  .mainH2,
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
                                              AppLocalizations.of(context)!
                                                  .mainH3,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: fontSmall,
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
                                            AppLocalizations.of(context)!
                                                .mainCredentials,
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
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .mainEmail,
                                            fillColor: Colors.white70,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 12.0),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .mainEmailError1;
                                            }
                                            final emailRegex = RegExp(
                                                r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');

                                            if (!emailRegex.hasMatch(value)) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .mainEmailError2;
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
                                            hintStyle: const TextStyle(
                                                color: Colors.grey),
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .mainPassword,
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
                                                if (this.mounted) {
                                                  setState(() {
                                                    if (mounted) {
                                                      _obscureText =
                                                          !_obscureText;
                                                    }
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return AppLocalizations.of(
                                                      context)!
                                                  .mainPasswordError1;
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
                                              return AppLocalizations.of(
                                                      context)!
                                                  .mainPasswordError2;
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
                                              bool connectionState =
                                                  await checkConnectivity();

                                              if (connectionState) {
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
                                                    _showErrorDialog(
                                                        context,
                                                        AppLocalizations.of(
                                                                context)!
                                                            .mainAuthErrorContent);
                                                  }
                                                }
                                              } else {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NoConnectivityView(),
                                                  ),
                                                );
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                            ),
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .mainLoginButton,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 15),
                                Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      final ClicksViewModel update =
                                          ClicksViewModel();
                                      update.updateClickCount("register");
                                      // Navigate to the registration view

                                      bool connectionState =
                                          await checkConnectivity();
                                      if (connectionState) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RegisterView(),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                NoConnectivityView(),
                                          ),
                                        );
                                      }
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text.rich(
                                        TextSpan(
                                          text: AppLocalizations.of(context)!
                                              .mainRegisterText1,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: fontSubtext,
                                          ),
                                          children: <TextSpan>[
                                            TextSpan(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .mainRegisterText2,
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
