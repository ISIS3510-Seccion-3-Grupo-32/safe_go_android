import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future< BitmapDescriptor> createCustomMarkerIcon() async {
  const iconData = Icons.location_on_outlined;
  final pictureRecorder = PictureRecorder();
  final canvas = Canvas(pictureRecorder);
  final textPainter = TextPainter(textDirection: TextDirection.ltr);
  final iconStr = String.fromCharCode(iconData.codePoint);
  textPainter.text = TextSpan(
      text: iconStr,
      style: TextStyle(
        letterSpacing: 0.0,
        fontSize: 48.0,
        fontFamily: iconData.fontFamily,
        color: Colors.black,
      )
  );
  textPainter.layout();
  textPainter.paint(canvas, const Offset(0.0, 0.0));
  final picture = pictureRecorder.endRecording();
  final image = await picture.toImage(48, 48);
  final bytes = await image.toByteData(format: ImageByteFormat.png);
  final bitmapDescriptor = BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  return bitmapDescriptor;
}
