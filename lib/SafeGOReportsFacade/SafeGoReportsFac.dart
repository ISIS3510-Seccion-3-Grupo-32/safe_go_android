import 'package:flutter/material.dart';
import '../View/SafeGoMap/SafeGoMap.dart';
import './reportDeliverSubsistem.dart';

class SafegoReportsFac extends StatelessWidget {
  const SafegoReportsFac({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const subject1 = "Dark, Unatendded Areas";
    const subject2 = "Smugglers, violence";
    const subject3 = "Pickpockets, intimidation";
    const subject4 = "Drug Dealing, Gang Activities";
    const userlocation = "TestLocation";
    const userDate = "TestDate";
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
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: RichText(
                            text: const TextSpan(
                              text: "Report Suspicious Activity\n",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: RichText(
                            text: const TextSpan(
                              text: "Select the Type of the Activity",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 40.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(99, 165, 136, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: ElevatedButton(
                                child: const Text(
                                  subject1,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                                onPressed: () {
                                  final ReportData report = ReportData(
                                      subject1, userlocation, userDate);
                                  report.sendReportData();
                                },
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 40.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(99, 165, 136, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Center(
                                child: Text(
                                  subject2,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 40.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(99, 165, 136, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Center(
                                child: Text(
                                  subject3,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 40.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color.fromRGBO(99, 165, 136, 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Center(
                                child: Text(
                                  subject4,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.left,
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 40.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Container(
                              decoration: const BoxDecoration(
                                  color: Color(0xffF5F5F5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              child: const Center(
                                child: Text(
                                  "Button in WIP We need Cloud of words First",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  textAlign: TextAlign.left,
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
