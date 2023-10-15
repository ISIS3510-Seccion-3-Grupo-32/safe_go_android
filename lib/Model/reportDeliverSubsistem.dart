import 'package:cloud_firestore/cloud_firestore.dart';

sendReportData(String Psubject, String collection) async {
  CollectionReference collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  print(collectionReferance.doc().set({"Subject": Psubject}));
  return (collectionReferance.doc().set({"Subject": Psubject}));
}
