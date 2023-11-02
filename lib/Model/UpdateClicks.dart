import 'package:cloud_firestore/cloud_firestore.dart';

updateClickValue(String documentId, String collection) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collection);

  // Update the "click" field with an increment operation
  await collectionReference.doc(documentId).update({
    "clicks": FieldValue.increment(1),
  });
}
