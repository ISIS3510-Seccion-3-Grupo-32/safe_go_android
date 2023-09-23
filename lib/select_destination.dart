import 'package:flutter/material.dart';
import 'package:safe_go_dart/select_destination_buttons.dart';

class SelectDestination extends StatelessWidget {
  const SelectDestination({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final spacingHeight = screenHeight * 0.02; // Adjust the factor as needed

    return Column(
      children: [
        SizedBox(height: spacingHeight),
        Padding(
          padding: const EdgeInsets.only(right: 10.0),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(248, 252, 252, 1),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                      hintText: 'Where to?',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: spacingHeight),
        DirectionButton(
          onPressed: () {
            // Action when the button is pressed
          },
          icon: Icons.home_outlined,
          label: 'Home',
        ),
        SizedBox(height: spacingHeight),
        DirectionButton(
          onPressed: () {
            // Action when the button is pressed
          },
          icon: Icons.work_outline,
          label: 'Work',
        ),
        SizedBox(height: spacingHeight),
        DirectionButton(
          onPressed: () {
            // Action when the button is pressed
          },
          icon: Icons.school_outlined,
          label: 'School',
        ),
        SizedBox(height: spacingHeight),
        DirectionButton(
          onPressed: () {
            // Action when the button is pressed
          },
          icon: Icons.favorite_outline,
          label: 'Partner',
        ),
      ],
    );
  }
}
