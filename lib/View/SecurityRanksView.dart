import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'dart:async';
import 'package:memory_cache/memory_cache.dart';
import 'package:safe_go_dart/Service Providers/FirebaseServiceProvider.dart';

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
    _fetchTheMostRepeatedHood();
    _fetchTheMostFelonyHood();
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
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
                          child: Text(
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
                          width: 300,
                          height: 160,
                          child: Center(
                            child: Text(
                              "Neighborhood with most Felonies: $mostFeloniesNeighborhood",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(216, 244, 228, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(216, 244, 228, 1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          width: 300,
                          height: 170,
                          child: Center(
                            child: Text(
                              textAlign: TextAlign.center,
                              "Neigborhood With Most \n Reports:$mostReportedHood",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        )
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
