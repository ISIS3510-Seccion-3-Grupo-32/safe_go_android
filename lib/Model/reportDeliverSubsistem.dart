import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
//Import firestore database
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class ReportData {
  final String subject;
  final String location;
  final String date;

  void sendReportData() {
    Future<Map<String, dynamic>> queryFirestore(String collection) async {
      final reportData = ["Subject", "Location", "Date"];
      FirebaseFirestore db = FirebaseFirestore.instance;
      Map<String, dynamic> reporte = {
        'Subject_Of_Report': reportData[0],
        'Location_Of_Report': reportData[1],
        'Date_Of_Report': reportData[2]
      };

      // Process the data from the querySnapshot

      return reporte;
    }
  }

  ReportData(this.subject, this.location, this.date);
}
