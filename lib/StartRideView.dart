import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class StartRideView extends StatelessWidget {
  const StartRideView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double espaciado = 30.0;
    double paddingPercentage = 0.05; // Adjust this percentage as needed
    double textPadding = MediaQuery.of(context).size.height * 0.025;
    double iconPadding = MediaQuery.of(context).size.width * paddingPercentage;

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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(18, textPadding, 0, 0),
                          child: Text(
                            'Your safe route is set!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: espaciado / 2,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            color: Colors.black,
                            height:
                                2.0, // Adjust the height of the Divider line as needed
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Icon(
                                  Icons.access_time,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 18.0,
                                  right: iconPadding,
                                ),
                                child: Text(
                                  '9:00 a.m',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: iconPadding,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Trip details:',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Icon(
                                  Icons.place_outlined,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: iconPadding,
                                  right: iconPadding,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      child: Text(
                                        'From: Cl 18# 1 -86',
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'To:      Cr 40 # 68 - 50',
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: iconPadding,
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Estimated time:',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: iconPadding),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(216, 244, 228, 1),
                                  borderRadius: BorderRadius.circular(60.0),
                                ),
                                child: Icon(
                                  Icons.timer_sharp,
                                  color: Color.fromRGBO(64, 78, 72, 1),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: iconPadding,
                                  right: iconPadding,
                                ),
                                child: Text(
                                  '36 minutes',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ), // Spacer
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
