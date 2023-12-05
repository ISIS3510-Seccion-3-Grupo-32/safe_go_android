import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

Future<List<Object>> getLatLong(String address) async {
  final url = Uri.parse("https://us-central1-safego-399621.cloudfunctions.net/manage-address");
  final body = {"address":address};
  final headers = {"Content-Type": "application/json"};
  final response = await http.post(url,headers: headers, body: jsonEncode(body));
  double lat = 0.0;
  double long =0.0;
  String validatedAddress = "";
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    lat = data["Latitude"];
    long = data["Longitude"];
    validatedAddress = data["Address"];
  } else {
    print("Failed to connect to the backend");
  }
  return [lat, long,validatedAddress];
}