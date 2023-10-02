import 'package:flutter/material.dart';

import 'SafeGoMap.dart';

class TravelDataView extends StatelessWidget {
  final String source;
  final String destination;
  final String date;

  const TravelDataView({super.key,
    required this.source,
    required this.destination,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
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
                flex: 1, // Set the flex factor for the registration container
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color(0xFF96CEB4),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50))),
                    child: Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            text: " $source \n",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                            children: const [],
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Container(
                          height: 150.0,
                          width: 500.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: Center(
                                child: Text(
                                  "Departure: $source\nArrival: $destination\nDate: $date\nReports during your travel: 0",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              )),
                        ),
                      ],
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
