import 'package:flutter/material.dart';
import 'package:safe_go_dart/View/SafeGoDetailedReports.dart';
import 'select_destination_buttons.dart';
import 'TravelHistoryView.dart';
import 'StartRideView.dart';
import '../ViewModel/ClicksViewModel.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'NoConnectivityView.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectDestination extends StatelessWidget {
  const SelectDestination({
    Key? key,
  }) : super(key: key);

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
    final ClicksViewModel update = ClicksViewModel();
    return Column(
      children: [
        const SizedBox(height: 14.0),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    fillColor: Color.fromRGBO(248, 252, 252, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(
                        style: BorderStyle.none,
                        strokeAlign: BorderSide.strokeAlignInside,
                        width: 0,
                        color: Color(0x00000001),
                      ),
                    ),
                    hintText: AppLocalizations.of(context)!.sdWhere,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(216, 244, 228, 1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.calendar_month,
                    color: Color.fromRGBO(64, 78, 72, 1),
                    size: 50,
                  ),
                  onPressed: () async {
                    update.updateClickCount("viewLastTrips");
                    bool connectionState = await checkConnectivity();

                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TravelHistoryView(),
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
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(216, 244, 228, 1),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.report_problem,
                    color: Colors.red,
                    size: 50,
                  ),
                  onPressed: () async {
                    update.updateClickCount("reportBug");

                    bool connectionState = await checkConnectivity();

                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SafeGoDetailedReports(),
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
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () async {
                    update.updateClickCount("goHome");

                    bool connectionState = await checkConnectivity();

                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StartRideView(),
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
                  icon: Icons.home_outlined,
                  label: AppLocalizations.of(context)!.sdHome,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () async {
                    update.updateClickCount("goToWork");
                    bool connectionState = await checkConnectivity();
                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StartRideView(),
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
                  icon: Icons.work_outline,
                  label: AppLocalizations.of(context)!.sdWork,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () async {
                    update.updateClickCount("goToSchool");
                    bool connectionState = await checkConnectivity();
                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StartRideView(),
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
                  icon: Icons.school_outlined,
                  label: AppLocalizations.of(context)!.sdSchool,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () async {
                    update.updateClickCount("goToPartner");
                    bool connectionState = await checkConnectivity();
                    if (connectionState) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const StartRideView(),
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
                  icon: Icons.favorite_outline,
                  label: AppLocalizations.of(context)!.sdPartner,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
