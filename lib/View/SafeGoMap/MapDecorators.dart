import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


import 'SafeGoMap.dart';

class MarkerDecorator extends SafeGoMap {
  final Set<Marker> markers;

  const MarkerDecorator({super.key,
    required this.markers,
    required SafeGoMap map});

  @override
  Widget decorate(SafeGoMap map) {
    return Stack(
      children: [
        map, // Build the base map.
        // Overlay markers on top of the base map.
      ],
    );
  }
}
