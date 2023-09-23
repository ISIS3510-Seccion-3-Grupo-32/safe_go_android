import 'package:flutter/material.dart';

class DirectionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const DirectionButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final buttonWidth = screenWidth * 0.9; // Adjust the factor as needed
    final buttonHeight = screenWidth * 0.1; // Adjust the factor as needed
    final iconSize = buttonWidth * 0.11; // Adjust the factor for icon size
    final fontSize = buttonWidth * 0.05; // Adjust the factor for font size

    return Container(
      width: buttonWidth,
      height: buttonHeight, // You can adjust the height independently if needed
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(216, 244, 228, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        icon: Icon(
          icon,
          color: const Color.fromRGBO(64, 78, 72, 1),
          size: iconSize,
        ),
        label: Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.normal,
            color: const Color.fromRGBO(64, 78, 72, 1),
          ),
        ),
      ),
    );
  }
}
