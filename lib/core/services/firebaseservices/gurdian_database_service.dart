import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/fireBaseModels/gurdisanfb.dart';

const String G_COLLECTION_REF = "guardian"; // Updated variable name

class GurdianDatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late final CollectionReference<GurdianFB> _guardiansRef; // Use late directly

  GurdianDatabaseService() {
    _guardiansRef =
        _firestore.collection(G_COLLECTION_REF).withConverter<GurdianFB>(
              fromFirestore: (snapshots, _) => GurdianFB.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (gurdisanfb, _) => gurdisanfb.toJson(),
            );
  }

  Stream<QuerySnapshot<GurdianFB>> getGuardians() {
    return _guardiansRef.snapshots();
  }

  Future<void> addGuardian(GurdianFB guardian) async {
    await _guardiansRef.add(guardian);
  }

  // Future<void> updateGuardian(String guardianId, GurdianFB guardian) async {
  //   await _guardiansRef.doc(guardianId).set(guardian.toJson());
  // }

  Future<void> deleteGuardian(String guardianId) async {
    await _guardiansRef.doc(guardianId).delete();

    Future<DocumentSnapshot?> getUserByFingerprint(String fingerprintID) async {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('digitalfingerprint', isEqualTo: fingerprintID)
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          return querySnapshot.docs.first;
        } else {
          return null; // User not found with the provided fingerprint ID
        }
      } catch (e) {
        print('Error getting user by fingerprint: $e');
        return null;
      }
    }
  }
}
