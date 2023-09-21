import 'package:flutter/material.dart';

class DirectionButton extends StatelessWidget {

  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  const DirectionButton({super.key, required this.onPressed, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(216,244,228,1),
          padding: const EdgeInsets.only(right: 228, left: 10, top: 20, bottom:20),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)),
      ), icon: Icon(icon,color: const Color.fromRGBO(64,78,72,1),size: 25,),
      label: Text(label,style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Color.fromRGBO(64,78,72,1))),
    );
  }
}
