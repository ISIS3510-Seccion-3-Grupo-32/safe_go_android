import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'dart:async';
import 'package:memory_cache/memory_cache.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SecurityRanksView extends StatefulWidget {
  const SecurityRanksView({Key? key}) : super(key: key);

  @override
  SecurityRanksViewState createState() => SecurityRanksViewState();
}

class SecurityRanksViewState extends State<SecurityRanksView> {
  late double fontHeader;
  String mostFeloniesNeighborhood = "";
  String mostReportedHood = "";
  @override
  void initState() {
    super.initState();
    _fetchTheMostFelonyHood();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _fetchTheMostFelonyHood() async {
    mostFeloniesNeighborhood = MemoryCache.instance.read<String>('Felonyhodd')!;
  }

  Future<void> _fetchTheMostRepeatedHood() async {
    mostReportedHood = MemoryCache.instance.read<String>('ReportedHood')!;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    _fetchTheMostRepeatedHood();
    _fetchTheMostFelonyHood();
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 2,
                child: SafeGoMap(),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF96CEB4),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Visibility(
                          visible: keyboardPadding == 0,
                          child: const Text(
                            "Security Ranks",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
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
                        Container(
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.09,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(216, 244, 228, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: Center(
                            child: Text(
                              "Neighborhood with most Felonies: $mostFeloniesNeighborhood",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(216, 244, 228, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          width: screenWidth * 0.9,
                          height: screenHeight * 0.09,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Neigborhood With Most Reports: $mostReportedHood",
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        Center(
                            // Enabling the Image Frame
                            child: SizedBox(
                                // To see the difference between the image's original size and the frame
                                width: screenWidth * 0.9,
                                height: screenHeight * 0.3,

                                // Uploading the Image from Assets
                                child: const Image(
                                  image: CachedNetworkImageProvider(
                                      'https://i.imgur.com/d1iagNz.png'),
                                )))
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
