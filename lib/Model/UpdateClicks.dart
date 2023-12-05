import 'package:cloud_firestore/cloud_firestore.dart';

updateClickValue(String documentId, String collection) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collection);


  await collectionReference.doc(documentId).update({
    "clicks": FieldValue.increment(1),
  });
}
