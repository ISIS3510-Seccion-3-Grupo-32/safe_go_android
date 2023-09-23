import 'package:flutter/material.dart';

class DirectionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;

  const DirectionButton({
    Key? key,
    required this.onPressed,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the screen width to calculate responsive padding
    final screenWidth = MediaQuery.of(context).size.width;

    // Calculate responsive padding based on screen width
    final horizontalPadding = screenWidth * 0.05; // 5% of screen width
    final verticalPadding = screenWidth * 0.02; // 2% of screen width

    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(216, 244, 228, 1),
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      icon: Icon(
        icon,
        color: const Color.fromRGBO(64, 78, 72, 1),
        size: screenWidth * 0.05, // 3% of screen width
      ),
      label: Text(
        label,
        style: TextStyle(
          fontSize: screenWidth * 0.04, // 2.5% of screen width
          fontWeight: FontWeight.normal,
          color: const Color.fromRGBO(64, 78, 72, 1),
        ),
      ),
    );
  }
}
