import 'package:cloud_firestore/cloud_firestore.dart';

updatePreferenceValue(String userId, String collection, bool isDarkMode,
    bool isNotificationsOn, double volume, String language) async {
  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection(collection);

  await collectionReference.doc(userId).update({
    "isDarkModeActive": isDarkMode,
    "isNotificationsOn": isNotificationsOn,
    "language": language,
    "soundVolume": volume
  });
}
