import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import the auto_size_text package
import 'SafeGoMap/SafeGoMap.dart';
import 'TravelDataView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TravelData {
  final String source;
  final String destination;
  final String date;

  TravelData(this.source, this.destination, this.date);
}

class TravelHistoryView extends StatelessWidget {
  const TravelHistoryView({super.key});

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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double paddingSides = screenWidth * 0.05;
    double paddingBetween = screenHeight * 0.01;
    const lightRedColor = Color.fromARGB(255, 231, 106, 106);

    // Define TextEditingController instances
    final fullNameController = TextEditingController();
    final passwordController = TextEditingController();
    final emailController = TextEditingController();
    final dobController = TextEditingController();

    // Define an array of travel data
    final List<TravelData> travelData = [
      TravelData("Source 1", "Destination 1", "Date 1"),
      TravelData("Source 2", "Destination 2", "Date 2"),
      TravelData("Source 3", "Destination 3", "Date 3"),
      TravelData("Source 4", "Destination 4", "Date 4"),
    ];

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
                          text: AppLocalizations.of(context)!.thTitle,
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
                      for (int i = 0; i < travelData.length; i++)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(paddingSides,
                                paddingBetween, paddingSides, paddingBetween),
                            child: SizedBox(
                              width: screenWidth * 0.8,
                              height: screenHeight * 0.06,
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool connectionState =
                                      await checkConnectivity();

                                  if (connectionState) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => TravelDataView(
                                            source: travelData[i].source,
                                            destination:
                                                travelData[i].destination,
                                            date: travelData[i].date),
                                      ),
                                    );
                                  } else {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const NoConnectivityView(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the radius as needed
                                  ),
                                ),
                                child: AutoSizeText(
                                  '${travelData[i].source} -> ${travelData[i].destination} ${travelData[i].date}',
                                  style: const TextStyle(color: Colors.black),
                                  maxLines:
                                      1, // Ensure the text fits on one line
                                ),
                              ),
                            ),
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(paddingSides,
                              paddingBetween, paddingSides, paddingBetween),
                          child: SizedBox(
                            width: screenWidth * 0.8,
                            height: screenHeight * 0.06,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightRedColor,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.thButton,
                                style: const TextStyle(color: Colors.black),
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
          );
        },
      ),
    );
  }
}
