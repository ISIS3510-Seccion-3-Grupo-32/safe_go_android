import 'package:cloud_firestore/cloud_firestore.dart';

sendReportData(String Psubject, String collection) async {
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  return (collectionReferance.doc().set({"Subject": Psubject}));
}

sendDetailedReportData(String Psubject, String collection) async {
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  print(collectionReferance.doc().set({"DetailedReport": Psubject}));
}
