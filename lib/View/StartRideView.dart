import 'package:flutter/material.dart';

import 'SafeGoMap/SafeGoMap.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartRideView extends StatelessWidget {
  const StartRideView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double espaciado = 30.0;
    double paddingPercentage = 0.05;
    double textPadding = MediaQuery.of(context).size.height * 0.025;
    double iconPadding = MediaQuery.of(context).size.width * paddingPercentage;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Expanded(
                flex: 1,
                child: SafeGoMap(),
              ),
              Expanded(
                flex: 2,
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
                            AppLocalizations.of(context)!.srTitle,
                            style: const TextStyle(
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
                            height: 2.0,
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
                                child: const Icon(
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
                                  AppLocalizations.of(context)!.srH2,
                                  style: const TextStyle(
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
                                AppLocalizations.of(context)!.srH2,
                                style: const TextStyle(
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
                                child: const Icon(
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
                                      padding: const EdgeInsets.only(
                                        left: 0,
                                        right: 0,
                                      ),
                                      child: Text(
                                        AppLocalizations.of(context)!.srFrom,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!.srTo,
                                      style: const TextStyle(
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
                                AppLocalizations.of(context)!.srTimeHeader,
                                style: const TextStyle(
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
                                child: const Icon(
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
                                  AppLocalizations.of(context)!.srTime,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
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
