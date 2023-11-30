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

  @override
  Widget build(BuildContext context) {
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
                        Text("Felonies hood : $mostFeloniesNeighborhood")
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
