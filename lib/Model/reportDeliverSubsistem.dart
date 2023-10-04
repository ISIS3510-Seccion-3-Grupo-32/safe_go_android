import 'package:cloud_firestore/cloud_firestore.dart';

sendReportData(String Psubject, String collection) async {
  CollectionReference _collectionReferance =
      FirebaseFirestore.instance.collection(collection);
  print(_collectionReferance.doc().set({"Subject": Psubject}));
  return (_collectionReferance.doc().set({"Subject": Psubject}));
}
