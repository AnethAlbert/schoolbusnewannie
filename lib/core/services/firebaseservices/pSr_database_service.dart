import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../../models/fireBaseModels/pSrfb.dart';
import '../../models/fireBaseModels/studentfb.dart';

const String pSr_COLLECTION_REF = "pSr"; // Updated variable name

class ParentStudentRelationFirebaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<ParentStudentRelation>
      _pSrRef; // Use late directly

  // pSrDatabaseService() {
  //   _pSrRef = _firestore.collection(pSr_COLLECTION_REF).withConverter<ParentStudentRelation>(
  //     fromFirestore: (snapshots, _) => ParentStudentRelation.fromJson(
  //       snapshots.data()!,
  //     ),
  //     toFirestore: (pSrfb, _) => pSrfb.toJson(),
  //   );
  // }

  Stream<List<StudentFB>> getStudentsByParentId(int parentId) {
    return _firestore
        .collection('parentStudentRelation')
        .where('parentId', isEqualTo: parentId)
        .snapshots()
        .asyncMap((snapshot) async {
      // Fetch the list of student IDs associated with the parent
      List<int> studentIds =
          snapshot.docs.map((doc) => doc['studentId'] as int).toList();

      // Fetch student documents based on the retrieved IDs
      List<StudentFB> students = [];
      for (int studentId in studentIds) {
        QuerySnapshot studentSnapshot = await _firestore
            .collection('students')
            .where('mysqlId', isEqualTo: studentId)
            .get();
        if (studentSnapshot.docs.isNotEmpty) {
          // Convert the document snapshot to a Student object
          DocumentSnapshot studentDoc = studentSnapshot.docs.first;
          StudentFB student =
              StudentFB.fromJson(studentDoc.data() as Map<String, dynamic>);
          students.add(student);
        }
      }
      return students;
    });
  }

  Stream<QuerySnapshot<ParentStudentRelation>> getpSr() {
    return _pSrRef.snapshots();
  }

  Future<void> addpSr(ParentStudentRelation pSr) async {
    await _pSrRef.add(pSr);
  }

  void updatepSr(String pSrid, ParentStudentRelation pSr) {
    _pSrRef.doc(pSrid).update(pSr.toJson());
  }

  Future<bool> deletepSr(int parentId, int studentId) async {
    bool result = false;
    try {
      await _firestore
          .collection('parentStudentRelation')
          .where('parentId', isEqualTo: parentId)
          .where('studentId', isEqualTo: studentId)
          .get()
          .then((value) async {
        if (kDebugMode) {
          print("DOCS SIZE: ${value.docs.length}");
        }
        for (var element in value.docs) {
          element.id;
          await _firestore
              .collection('parentStudentRelation')
              .doc(element.id)
              .delete();
        }
        result = true;
      });
      return result;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return false;
    }
  }
}
