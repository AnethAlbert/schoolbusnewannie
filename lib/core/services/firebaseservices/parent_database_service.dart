import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/fireBaseModels/parentfb.dart';

const String P_COLLECTION_REF = "parent"; // Updated variable name

class ParentDatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<ParentFB> _parentsRef; // Use late directly

  ParentDatabaseService() {
    _parentsRef =
        _firestore.collection(P_COLLECTION_REF).withConverter<ParentFB>(
              fromFirestore: (snapshots, _) => ParentFB.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (parentfb, _) => parentfb.toJson(),
            );
  }

  Stream<QuerySnapshot<ParentFB>> getParents() {
    // Updated return type
    return _parentsRef.snapshots();
  }

  Future<void> addParent(ParentFB parent) async {
    // Added async and await
    await _parentsRef.add(parent);
  }

  void updateParent(String parentId, ParentFB parent) {
    // Updated method name
    _parentsRef.doc(parentId).update(parent.toJson());
  }

  void deleteParent(String parentId) {
    // Updated method name
    _parentsRef.doc(parentId).delete();
  }
}
