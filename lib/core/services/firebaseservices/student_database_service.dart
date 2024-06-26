import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/fireBaseModels/studentfb.dart';

const String COLLECTION_REF = "student"; // Updated variable name

class StudentDatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference<StudentFB> _studentsRef; // Use late directly

  StudentDatabaseService() {
    _studentsRef =
        _firestore.collection(COLLECTION_REF).withConverter<StudentFB>(
              fromFirestore: (snapshots, _) => StudentFB.fromJson(
                snapshots.data()!,
              ),
              toFirestore: (studentfb, _) => studentfb.toJson(),
            );
  }

  Stream<QuerySnapshot<StudentFB>> getStudents() {
    return _studentsRef.snapshots();
  }

  Future<void> addStudent(StudentFB student) async {
    await _studentsRef.add(student);
  }

  void updateStudentString(String studentId, StudentFB student) {
    _studentsRef.doc(studentId).update(student.toJson());
  }

  void deleteStudent(String studentID) {
    _studentsRef.doc(studentID).delete();
  }
}
