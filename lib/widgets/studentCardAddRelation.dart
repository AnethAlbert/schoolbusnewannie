import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';

import '../core/services/pSr_apiService.dart';

class StudentCardAddRelation extends StatefulWidget {
  final int id;
  final String fname;
  final String lname;
  final int age;
  final int parentId;
  final Uint8List? profilePicture;

  const StudentCardAddRelation({
    Key? key,
    required this.id,
    required this.fname,
    required this.lname,
    required this.age,
    required this.parentId,
    this.profilePicture,
  }) : super(key: key);

  @override
  State<StudentCardAddRelation> createState() => _StudentCardAddRelationState();
}

class _StudentCardAddRelationState extends State<StudentCardAddRelation> {
  Future<void> addStudentParentRelation(
      int parentId, int studentId, BuildContext context) async {
    try {
      // Call the API service function to add parent-student relation in MySQL
      await ParentStudentRelationApiService()
          .addParentStudentRelation(parentId, studentId, context);

      // Add parent-student relation to Firestore
      await FirebaseFirestore.instance.collection('parentStudentRelation').add({
        'parentId': parentId,
        'studentId': studentId,
        // Add more fields as needed
      });

      // Insertion successful, you can handle it here
      // For example, show a success message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Parent-student relation added successfully')));
    } catch (error) {
      // Insertion failed, handle the error
      // For example, show an error message to the user
      print('Error adding parent-student relation: $error');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add parent-student relation')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: widget.profilePicture != null
                ? Image.memory(widget.profilePicture!).image
                : const AssetImage(
                    'assets/images/student.jpg'), // Placeholder image
          ),
          // CircleAvatar(
          //   radius: 36,
          //   backgroundImage: NetworkImage(
          //     'https://media.istockphoto.com/id/1353379172/photo/cute-little-african-american-girl-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=KI0p6tdb1rV8Uj-A9095dhtlD6RYSQcILmbCJgfPMMU=',
          //   ),
          // ),
          title: const Text(
            'Keifo Primary School',
            style: TextStyle(fontSize: 13.0),
          ),
          subtitle: Text(
            '${widget.fname} (${widget.age})',
            style: const TextStyle(fontSize: 12.0),
          ),

          trailing: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Relation"),
                    content: Container(
                      width: double.maxFinite,
                      // Expand container to full width
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: MemoryImage(widget
                                .profilePicture!), // Use MemoryImage to load profile picture data
                          ),

                          SizedBox(width: 16),
                          // Add spacing between profile picture and text
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Student ID: ${widget.id}"),
                                Text("First Name: ${widget.fname}"),
                                Text("Last Name: ${widget.lname}"),
                                Text("Age: ${widget.age}"),
                                const Text(
                                    "Are you sure you want to relate this student?"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call the method to add student parent relation
                          addStudentParentRelation(
                              widget.parentId, widget.id, context);
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text(
                          "Relate",
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.linearMiddle,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0),
              ),
            ),
            child: const Text(
              'Relate',
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
