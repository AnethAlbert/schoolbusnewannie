import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FingerprintIdService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getNewFingerprintId() async {
    String? fingerprintId;
    try {
      DocumentSnapshot<Map<String, dynamic>> docs = await _firestore
          .collection("fingerprint_id")
          .doc("fingerprint_id")
          .get();
      fingerprintId = docs.data()?["fingerprint_id"].toString() ?? "1";
      return fingerprintId;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("FINGERPRINT ID ERROR: $e");
      }
      return null;
    }
  }

  Future<void> updateFingerprintId() async {
    try {
      int currentFingerprintId;
      DocumentSnapshot<Map<String, dynamic>> docs = await _firestore
          .collection("fingerprint_id")
          .doc("fingerprint_id")
          .get();
      currentFingerprintId =
          int.parse(docs.data()?["fingerprint_id"].toString() ?? "1") + 1;
      await _firestore
          .collection("fingerprint_id")
          .doc("fingerprint_id")
          .set({"fingerprint_id": (currentFingerprintId).toString()});
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("FINGERPRINT ID ERROR: $e");
      }
    }
  }
}
