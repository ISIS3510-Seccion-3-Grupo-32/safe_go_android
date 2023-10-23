import 'package:flutter/material.dart';
import 'package:safe_go_dart/View/select_destination.dart';
import 'SafeGoMap/SafeGoMap.dart';
import '../ViewModel/ReportsViewModel.dart';

class SafegoDetailedReportsSubSisView extends StatelessWidget {
  const SafegoDetailedReportsSubSisView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const userlocation = "TestLocation";
    const userDate = "TestDate";
    var myController = TextEditingController();

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
                              text: "Tell us more about what happened",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3.0),
                          height: 52.0,
                          width: 370.0,
                          color: Colors.transparent,
                          child: Expanded(
                            child: SizedBox(
                              child: TextField(
                                controller: myController,
                                maxLines: null,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(),
                                  hintText: 'Write your Detailed Report Here',
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromRGBO(
                                99, 165, 136, 1), // Background color
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            textAlign: TextAlign.left,
                          ),
                          onPressed: () {
                            final ReportsViewModel report = ReportsViewModel();
                            report.sendDetailedReport(myController.text);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SelectDestination(),
                              ),
                            );
                          },
                        )
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
