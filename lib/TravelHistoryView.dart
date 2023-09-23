import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:auto_size_text/auto_size_text.dart'; // Import the auto_size_text package
import 'TravelDataView.dart';

class TravelData {
  final String source;
  final String destination;
  final String date;

  TravelData(this.source, this.destination, this.date);
}

class TravelHistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double fontRegister = screenHeight * 0.05;
    double fontInputs = screenHeight * 0.04;
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
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Your Travels",
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
                                onPressed: () {
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
                                },
                                child: AutoSizeText(
                                  '${travelData[i].source} -> ${travelData[i].destination} ${travelData[i].date}',
                                  style: TextStyle(color: Colors.black),
                                  maxLines:
                                      1, // Ensure the text fits on one line
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust the radius as needed
                                  ),
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
                              child: Text(
                                "Delete Travel's history",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: lightRedColor,
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
