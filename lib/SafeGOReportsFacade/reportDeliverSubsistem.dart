import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportData {
  final String subject;
  final String location;
  final String date;

  ReportData(this.subject, this.location, this.date);
}

Future<int> queryFirestore(String collection) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  //QuerySnapshot querySnapshot = await db.collection(collection).add();
  // Process the data from the querySnapshot
  int totalRecords = querySnapshot.size;
  print(totalRecords);
  return totalRecords;
}
