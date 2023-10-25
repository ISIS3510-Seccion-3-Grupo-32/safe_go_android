import 'package:flutter/material.dart';
import 'select_destination_buttons.dart';
import 'TravelHistoryView.dart';
import 'StartRideView.dart';
import 'SafeGoReportsView.dart';

class SelectDestination extends StatelessWidget {
  const SelectDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 14.0),
        Row(
          children: [
            const Expanded(
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
                    hintText: 'Where to?',
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TravelHistoryView(),
                      ),
                    );
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SafegoReportsFac(),
                      ),
                    );
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartRideView(),
                      ),
                    );
                  },
                  icon: Icons.home_outlined,
                  label: 'Home',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartRideView(),
                      ),
                    );
                  },
                  icon: Icons.work_outline,
                  label: 'Work',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartRideView(),
                      ),
                    );
                  },
                  icon: Icons.school_outlined,
                  label: 'School',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StartRideView(),
                      ),
                    );
                  },
                  icon: Icons.favorite_outline,
                  label: 'Partner',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
