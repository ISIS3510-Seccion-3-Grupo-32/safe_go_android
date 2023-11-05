import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

sendReportData(String Psubject, String collection) async {
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  return (collectionReferance.doc().set({"Subject": Psubject}));
}

sendDetailedReportData(String Psubject, String collection) async
{
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  double? lat = prefs.getDouble('lat');
  double? long = prefs.getDouble('long');
  CollectionReference collectionReferance = FirebaseFirestore.instance.collection(collection);
  print(collectionReferance.doc().set({"DetailedReport": Psubject,
  "Latitude": lat, "Longitude":long}));
}
