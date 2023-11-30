import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

 Future<LatLng> getLatLong(String address) async {
  final url = Uri.parse("https://maps.googleapis.com/maps/api/geocode/json?address=$address,Bogota,Colombia&key=AIzaSyAobEzu1GD_Dz3m7Mv_stPDohN80pWgZlU");
  final response = await http.get(url);
  double lat = 0.0;
  double long =0.0;
  print(response);
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    lat = data["results"][0]["geometry"]["location"]["lat"];
    long = data["results"][0]["geometry"]["location"]["lng"];

  } else {
    print("Failed to connect to the backend");
  }
  return LatLng (lat, long);
}