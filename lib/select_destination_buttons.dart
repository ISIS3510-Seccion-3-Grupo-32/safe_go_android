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
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(216,244,228,1),
          padding: const EdgeInsets.only(right: 228, left: 10, top: 20, bottom:14),

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
