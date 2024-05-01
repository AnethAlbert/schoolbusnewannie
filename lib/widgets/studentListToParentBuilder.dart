import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:newschoolbusapp/models/student.dart';
import 'package:newschoolbusapp/services/firebaseservices/pSr_database_service.dart';
import 'package:newschoolbusapp/models/fireBaseModels/studentfb.dart';

class StudentListBuilder extends StatefulWidget {
  final int parent_id;

  const StudentListBuilder({Key? key, required this.parent_id})
      : super(key: key);

  @override
  State<StudentListBuilder> createState() => _StudentListBuilderState();
}

class _StudentListBuilderState extends State<StudentListBuilder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder<List<StudentFB>>(
        stream: pSrDatabaseService().getStudentsByParentId(widget.parent_id!),
        // Use FirestoreService to get students
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<StudentFB>? students = snapshot.data;
            if (students != null && students.isNotEmpty) {
              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  StudentFB student = students[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                        child: Container(
                          height: 80,
                          width: 420,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: student.profilepicture != null &&
                                          student.profilepicture!.isNotEmpty
                                      ? CircleAvatar(
                                          radius: 30,
                                          backgroundImage: MemoryImage(
                                              base64Decode(
                                                  student.profilepicture!)),
                                        )
                                      : Text('No image selected'),
                                ),
                              ),
                              // Display student profile picture here
                              SizedBox(width: 50),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${student.fname} ${student.lname} (${student.mysqlId})",
                                  ),
                                  Text("Class 7"),
                                  Text("Age ${student.age}"),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                    icon: Icon(Icons.cancel),
                                    onPressed: () {
                                      // Add your onPressed function here
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('No students found'));
            }
          }
        },
      ),
    );
  }
}

// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:ui';
//
// import 'package:flutter/material.dart';
// import 'package:schoolbassapp/models/student.dart';
// import 'package:schoolbassapp/services/Student_apiService.dart';
//
//
// class StudentListBuilder extends StatefulWidget {
//   final int parent_id;
//
//
//   const StudentListBuilder({Key? key, required this.parent_id}) : super(key: key);
//
//   @override
//   State<StudentListBuilder> createState() => _StudentListBuilderState();
// }
//
// class _StudentListBuilderState extends State<StudentListBuilder> {
//   String? profilepicture;
//
//   Future<Widget> showImage() async {
//     if (profilepicture != null && profilepicture!.isNotEmpty) {
//       // Load profile picture asynchronously
//       Uint8List imageData = await fetchImage(profilepicture!);
//       return CircleAvatar(
//         radius: 30,
//         backgroundImage: MemoryImage(imageData),
//       );
//     } else {
//       return Center(
//         child: Text('No image selected'),
//       );
//     }
//   }
//
//   Future<Uint8List> fetchImage(String profilepicture) async {
//     Uint8List imageData = base64Decode(profilepicture);
//     return imageData;
//   }
//
// //StudentApiService().getParentStudentRelationById(parent_id),
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: StreamBuilder<List<Student>?>(
//         stream: StudentApiService().parentStudentRelationStream(widget.parent_id),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             List<Student>? students = snapshot.data;
//             if (students != null && students.isNotEmpty) {
//               return ListView.builder(
//                 itemCount: students.length,
//                 itemBuilder: (context, index) {
//                   Student student = students[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(20),
//                       child: BackdropFilter(
//                         filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//                         child: Container(
//                           height: 80,
//                           width: 420,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.5),
//                           ),
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child:
//                                 FutureBuilder<Widget>(
//                                   future: showImage(),
//                                   builder: (context, snapshot) {
//                                     if (snapshot.connectionState == ConnectionState.waiting) {
//                                       return CircularProgressIndicator(); // Placeholder while loading
//                                     } else {
//                                       if (snapshot.hasError) {
//                                         return Text('Error loading image'); // Handle error
//                                       } else {
//                                         return snapshot.data!; // Return the image widget
//                                       }
//                                     }
//                                   },
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "${student.fname} ${student.lname} (${student.id})",
//                                   ),
//                                   Text("Class 7"),
//                                   Text("Age ${student.age}"),
//                                 ],
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   alignment: Alignment.centerRight,
//                                   child: IconButton(
//                                     icon: Icon(Icons.cancel),
//                                     onPressed: () {
//                                       // Add your onPressed function here
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             } else {
//               return Center(child: Text('No students found'));
//             }
//           }
//         },
//       ),
//     );
//
//   }
// }
