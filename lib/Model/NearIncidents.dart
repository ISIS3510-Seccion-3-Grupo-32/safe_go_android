import 'package:cloud_firestore/cloud_firestore.dart';

Future<int> queryFirestore(String collection) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  QuerySnapshot querySnapshot = await db.collection(collection).get();
  // Process the data from the querySnapshot
  int totalRecords = querySnapshot.size;
  print(totalRecords);
  return totalRecords;
}
