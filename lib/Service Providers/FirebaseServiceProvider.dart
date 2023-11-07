import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

sendReportData(String Psubject, String collection) async {
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  return (collectionReferance.doc().set({"Subject": Psubject}));
}

sendDetailedReportDataToBack(
  String psubject,
  String collection,
) async {
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  double? lat = prefs.getDouble('lat');
  double? long = prefs.getDouble('long');
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  print(collectionReferance
      .doc()
      .set({"DetailedReport": psubject, "Latitude": lat, "Longitude": long}));
}

Future<String> getMostFeloniesHood() async {
  final url = Uri.parse(
      "https://us-central1-safego-399621.cloudfunctions.net/RankFelonyNeighboorhood");
  final headers = {"Content-Type": "application/json"};
  final body = {"input_text": "hello world!"};
  String responseString = "crashes";
  final response =
      await http.post(url, headers: headers, body: jsonEncode(body));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    responseString = data["neighborhood_with_most_felonies"];
    // Do something with the category (e.g., display it in your app)

    // Save the response as a string
    print("Response as a string: $responseString");
  } else {
    print("Failed to connect to the backend");
  }
  return responseString;
}
