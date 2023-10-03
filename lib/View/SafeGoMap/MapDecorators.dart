import 'package:flutter/material.dart';


import 'SafeGoMap.dart';

class MarkerDecorator extends SafeGoMap {

  const MarkerDecorator({super.key,
    required SafeGoMap map});

  get markers => null;

  @override
  Widget decorate(SafeGoMap map) {
    return Scaffold(
      body: Stack(
          children: [
            Positioned(child:
            map
            ),
            const Positioned(
              top: 16.0, // Adjust the top and left values as needed
              left: 16.0,
              child: Icon(Icons.location_on),
            ),
          ],
        ),
    );
  }
}
