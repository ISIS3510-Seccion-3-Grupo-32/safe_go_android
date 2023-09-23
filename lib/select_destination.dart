import 'package:flutter/material.dart';
import 'package:safe_go_dart/select_destination_buttons.dart';

class SelectDestination extends StatelessWidget {
  const SelectDestination({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 14.0),
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
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    // Action when the button is pressed
                  },
                  icon: Icons.home_outlined,
                  label: 'Home',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    // Action when the button is pressed
                  },
                  icon: Icons.work_outline,
                  label: 'Work',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    // Action when the button is pressed
                  },
                  icon: Icons.school_outlined,
                  label: 'School',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DirectionButton(
                  onPressed: () {
                    // Action when the button is pressed
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
