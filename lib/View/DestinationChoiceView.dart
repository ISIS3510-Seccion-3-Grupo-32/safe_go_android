import 'package:flutter/material.dart';
import 'SafeGoMap/SafeGoMap.dart';
import 'select_destination.dart';
import 'SettingsView.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';

class DestinationChoiceView extends StatelessWidget {
  bool selected = false;

  DestinationChoiceView({super.key});

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
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(children: [
              const SafeGoMap(),
              Positioned(
                top: 32, // Adjust the position as needed
                left: 16, // Adjust the position as needed
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(152, 204, 180, 1),
                  ),
                  child: IconButton(
                      onPressed: () async {
                        bool connectionState = await checkConnectivity();

                        if (connectionState) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsView(),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NoConnectivityView(),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.menu)),
                ),
              ),
            ]),
          ),
          Expanded(
            child: AnimatedContainer(
              padding: const EdgeInsets.only(left: 40, bottom: 20, right: 40),
              alignment: selected
                  ? Alignment.bottomCenter
                  : AlignmentDirectional.bottomCenter,
              duration: const Duration(seconds: 1),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(152, 204, 180, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              curve: Curves.linear,
              child: (1 == 1)
                  ? const SelectDestination()
                  : const SelectDestination(),
            ),
          ),
        ],
      ),
    );
  }
}
