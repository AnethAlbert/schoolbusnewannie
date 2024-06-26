import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newschoolbusapp/widgets/studentCard.dart';
import 'package:newschoolbusapp/widgets/studentCardAddRelation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/models/fireBaseModels/studentfb.dart';

class serchTextfield extends StatefulWidget {
  final int parentId;

  const serchTextfield({Key? key, required this.parentId}) : super(key: key);

  @override
  State<serchTextfield> createState() => _serchTextfieldState();
}

class _serchTextfieldState extends State<serchTextfield> {
  bool showContainer = false;
  final Controller = TextEditingController();

  List<Map<String, dynamic>> studentsSearch = [];
  String? selecteStudentSearch;

  @override
  void initState() {
    super.initState();
    // Fetch classes when the widget initializes
    fetchStudent1();
  }

  Future<void> fetchStudent1() async {
    try {
      // Query Firestore to get all documents from the 'student' collection
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('students').get();

      // Convert each document to a Student object and store them in a list
      List<StudentFB> fetchedStudents = querySnapshot.docs.map((doc) {
        return StudentFB(
          firebaseId: doc['firebaseId'],
          mysqlId: doc['mysqlId'],
          fname: doc['fname'],
          lname: doc['lname'],
          age: doc['age'],
          profilepicture: doc['profilepicture'],
          // Add more fields as needed
        );
      }).toList();

      setState(() {
        studentsSearch = fetchedStudents.map((student) {
          return {
            'fieabaseId': student.firebaseId,
            'mysqlId': student.mysqlId,
            'name': '${student.fname} ${student.lname} (${student.age})',
            'fname': student.fname,
            'lname': student.lname,
            'age': student.age,
            'profilepicture': student.profilepicture,
            // Add profilepicture field
          };
        }).toList();

        selecteStudentSearch =
            studentsSearch.isNotEmpty ? studentsSearch.first['name'] : null;

        // Update the flag based on search results
        showContainer = studentsSearch.isNotEmpty;
      });

      // Print student names and IDs
      for (var student in studentsSearch) {
        print('Student ID: ${student['id']}, Name: ${student['name']}');
      }
    } catch (error) {
      print('Error fetching student: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextField(
            controller: Controller,
            decoration: InputDecoration(
                filled: true,
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search Student Here',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.white70))),
            onChanged: searchStudents,
            // searchStudent,
          ),

          // Conditionally show the Container
          if (showContainer)
            Container(
              height: 300,
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: Expanded(
                child: ListView.builder(
                  itemCount: studentsSearch.length,
                  itemBuilder: (context, index) {
                    // Get the profile picture base64 string from studentsSearch
                    String? profilePictureBase64 =
                        studentsSearch[index]['profilepicture'];

                    // Decode the base64-encoded profilepicture to Uint8List
                    Uint8List? profilePictureBytes =
                        profilePictureBase64 != null
                            ? base64Decode(profilePictureBase64)
                            : null;

                    // Debugging: Print profile picture data
                    // print("Profile Picture Base64 for Student ${studentsSearch[index]['id']}: $profilePictureBase64");
                    print(
                        "Profile Picture Bytes for Student ${studentsSearch[index]['mysqlId']}: $profilePictureBytes");

                    return StudentCardAddRelation(
                      id: studentsSearch[index]['mysqlId'] ?? '',
                      fname: studentsSearch[index]['fname'] ?? '',
                      lname: studentsSearch[index]['lname'] ?? '',
                      age: studentsSearch[index]['age'] ?? '',
                      parentId: widget.parentId,
                      profilePicture:
                          profilePictureBytes, // Pass the profile picture bytes
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  void searchStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all students
        fetchStudent1();
      } else {
        studentsSearch = studentsSearch.where((student) {
          final studentName = student['fname'] as String? ?? '';
          final input = query.toLowerCase();
          if (studentName != null) {
            return studentName.toLowerCase().contains(input);
          } else {
            return false; // Handle null values if needed
          }
        }).toList();
      }
    });
  }

// void searchStudents(String query) {
//   setState(() {
//     if (query.isEmpty) {
//       // If the query is empty, show all students
//       fetchStudent1();
//     } else {
//       studentsSearch = studentsSearch.where((student) {
//         final studentName = student['fname'] as String? ?? '';
//         final input = query.toLowerCase();
//         return studentName.toLowerCase().contains(input);
//       }).toList();
//
//       // Update the flag based on search results
//       showContainer = studentsSearch.isNotEmpty;
//     }
//   });
// }
}
