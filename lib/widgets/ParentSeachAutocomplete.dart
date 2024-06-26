import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/AddparentStudentrelation.dart';
import 'package:newschoolbusapp/widgets/parentCard.dart';

import '../core/models/fireBaseModels/parentfb.dart';
import '../core/models/parent.dart';
import '../core/models/student.dart';
import '../core/services/Parent_apiService.dart';
import '../core/services/Student_apiService.dart';
import '../core/services/firebaseservices/parent_database_service.dart';
import '../core/services/pSr_apiService.dart';
import '../core/utils/app_colors.dart';

class autocomplete extends StatefulWidget {
  const autocomplete({Key? key}) : super(key: key);

  @override
  State<autocomplete> createState() => _autocompleteState();
}

class _autocompleteState extends State<autocomplete> {
  final Controller = TextEditingController();

  List<Map<String, dynamic>> parents = [];
  List<Map<String, dynamic>> parentss = [];
  String? selectedParentt;
  String? selectedParent;

  List<ParentFB> parentsFB = [];
  String? selectedParentFB;

  // List<Map<String, dynamic>> parentsFB = [];
  // String? selectedParentFB;
  // List<ParentFB> parentlistList = [];

  List<Map<String, dynamic>> studentsSearch = [];
  String? selecteStudentSearch;

  List<Map<String, dynamic>> studentsSearchFB = [];
  String? selecteStudentSearchFB;

  String? DocId;

  @override
  void initState() {
    super.initState();
    // Fetch classes when the widget initializes
    fetchParentss();
    //fetchParentsFB();
    // fetchParentss();
    // fetchParents();
    fetchStudent1();
  }

  Future<void> fetchParentsFB() async {
    try {
      List<ParentFB> fetchedParents = [];

      print("Fetching parents from Firebase...");

      await for (var snapshot in ParentDatabaseService().getParents()) {
        fetchedParents = snapshot.docs.map((doc) => doc.data()).toList();
        break;
      }

      setState(() {
        parentsFB = fetchedParents;
        selectedParentFB = parentsFB.isNotEmpty ? parentsFB.first.fname : null;
      });

      // Print parent names and IDs
      for (var parent in parentsFB) {
        print(
            'Parent Names From Firebase: ${parent.fname} ${parent.lname}  ${parent.phone}');
      }

      print("Parents fetched successfully.");
    } catch (error, stackTrace) {
      print('Error fetching parents: $error');
      //r print(stackTrace);
      // Handle error as needed
    }
  }

  //
  // Future<void> fetchParents() async {
  //   try {
  //     List<Parent> fetchedParents = await ParentApiService().getAllParents();
  //
  //     for (var parent in fetchedParents) {
  //       // Get the MySQL ID from the parent
  //       int mysqlId = parent.id!;
  //
  //       // Retrieve the Firestore document ID based on the MySQL ID
  //       String docId = await _getFirestoreDocumentId(mysqlId);
  //
  //       // Assign the Firestore document ID to the parent object
  //       parent.docId = docId;
  //     }
  //
  //     setState(() {
  //       parents = fetchedParents.map((parent) {
  //         return {
  //           'id': parent.id,
  //           'fname': parent.fname ?? '',
  //           'lname': parent.lname ?? '',
  //           'email': parent.email,
  //           'phone': parent.phone,
  //           'docId': parent.docId ?? '', // Use the retrieved Firestore document ID
  //         };
  //       }).toList();
  //       selectedParent = parents.isNotEmpty ? parents.first['name'] : null;
  //     });
  //
  //     // Print parent names, IDs, and Firestore document IDs
  //     for (var parent in parents) {
  //       print('Parent ID: ${parent['id']}, Name: ${parent['fname']} ${parent['lname']}, Firestore Doc ID: ${parent['docId']}');
  //     }
  //   } catch (error) {
  //     print('Error fetching parents: $error');
  //     // Handle error as needed
  //   }
  // }

  Future<void> fetchParentss() async {
    try {
      // Stream parent data directly from Firestore
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('parents').get();

      List<ParentFB> fetchedParents = querySnapshot.docs
          .map<ParentFB>((doc) => ParentFB.fromFirestore(doc))
          .toList();

      setState(() {
        parentss = fetchedParents.map((parent) {
          return {
            'firebaseId': parent.firebaseId ?? '',
            'mysqlId': parent.mysqlId ?? '',
            'fname': parent.fname ?? '',
            'lname': parent.lname ?? '',
            'email': parent.email ?? '',
            'phone': parent.phone ?? '',
            'profilepicture': parent.profilepicture ?? '',
          };
        }).toList();
        selectedParentt = parents.isNotEmpty ? parents.first['name'] : null;
      });

      // Print parent names, IDs, and Firestore document IDs
      for (var parent in parents) {
        print(
            'Parent ID: ${parent['id']}, Name: ${parent['fname']} ${parent['lname']},mysqlId : ${parent['mysqlId']}, Firestore Doc ID: ${parent['firebaseId']},');
        // Check if the document ID is not null and not empty before calling _getProfilePicture
        if (parent['docId'] != null && parent['docId'].isNotEmpty) {
          // Call _getProfilePicture method if needed
        } else {
          print('Invalid Firestore document ID for parent ID ${parent['id']}');
        }
      }
    } catch (error) {
      print('Error fetching parents: $error');
      // Handle error as needed
    }
  }

  Future<void> fetchParents() async {
    try {
      List<Parent> fetchedParents = await ParentApiService().getAllParents();

      // Create a list to store Future objects for Firestore queries
      List<Future<void>> firestoreQueries = [];

      for (var parent in fetchedParents) {
        // Get the MySQL ID from the parent
        int mysqlId = parent.id!;

        // Queue Firestore queries asynchronously
        firestoreQueries.add(_getFirestoreDocumentId(mysqlId).then((docId) {
          // Assign the Firestore document ID to the parent object if it's not empty
          if (docId != null && docId.isNotEmpty) {
            parent.docId = docId;
          } else {
            print('Invalid Firestore document ID for parent ID ${parent.id}');
          }
        }));
      }

      // Wait for all Firestore queries to complete
      await Future.wait(firestoreQueries);

      setState(() {
        parents = fetchedParents.map((parent) {
          return {
            'id': parent.id,
            'fname': parent.fname ?? '',
            'lname': parent.lname ?? '',
            'email': parent.email,
            'phone': parent.phone,
            'docId': parent.docId ?? '',
            // Use the retrieved Firestore document ID
          };
        }).toList();
        selectedParent = parents.isNotEmpty ? parents.first['name'] : null;
      });

      // Print parent names, IDs, and Firestore document IDs
      for (var parent in parents) {
        print(
            'Parent ID: ${parent['id']}, Name: ${parent['fname']} ${parent['lname']}, Firestore Doc ID: ${parent['docId']}');
        // Check if the document ID is not null and not empty before calling _getProfilePicture
        if (parent['docId'] != null && parent['docId'].isNotEmpty) {
        } else {
          print('Invalid Firestore document ID for parent ID ${parent['id']}');
        }
      }
    } catch (error) {
      print('Error fetching parents: $error');
      // Handle error as needed
    }
  }

  Future<String> _getFirestoreDocumentId(int mysqlId) async {
    try {
      // Query Firestore to find the document with matching mysqlId
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('parents')
          .where('mysqlId', isEqualTo: mysqlId)
          .get();

      // Check if any documents match the query
      if (querySnapshot.docs.isNotEmpty) {
        // Return the document ID of the first matching document
        return querySnapshot.docs.first.id;
      } else {
        // Handle the case where no matching document is found
        return '';
      }
    } catch (error) {
      // Handle error while querying Firestore
      print('Error retrieving Firestore document ID: $error');
      return '';
    }
  }

  // Future<void> fetchParents() async {
  //   try {
  //     List<Parent> fetchedParents = await ParentApiService().getAllParents();
  //
  //     setState(() {
  //       parents = fetchedParents.map((parent) {
  //         return {
  //           'id': parent.id,
  //           'fname': parent.fname ?? '',
  //           'lname': parent.lname ?? '',
  //           'email': parent.email,
  //           'phone': parent.phone,
  //         };
  //       }).toList();
  //       selectedParent = parents.isNotEmpty ? parents.first['name'] : null;
  //     });
  //
  //     // Print parent names and IDs
  //     for (var parent in parents) {
  //       print(
  //           'Parent ID: ${parent['id']}, Name: ${parent['fname']} ${parent['lname']}');
  //     }
  //   } catch (error) {
  //     print('Error fetching parents: $error');
  //     // Handle error as needed
  //   }
  // }

  Future<void> fetchStudent1() async {
    try {
      List<Student> fetchedStudents =
          await StudentApiService().getAllStudents();
      setState(() {
        studentsSearch = fetchedStudents.map((student) {
          return {
            'id': student.id,
            'name': '${student.fname} ${student.lname} (${student.age})',
            'fname': student.fname,
            'lname': student.lname,
            'age': student.age,
          };
        }).toList();

        selecteStudentSearch =
            studentsSearch.isNotEmpty ? studentsSearch.first['name'] : null;
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

  addStudentParentRelation(
      int parentId, int studentId, BuildContext context) async {
    try {
      // Call the API service function to add parent-student relation
      await ParentStudentRelationApiService()
          .addParentStudentRelation(parentId, studentId, context);

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
    return SafeArea(
      child: Scaffold(
        // body: ParentListScreen(),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.linearTop,
                AppColors.linearBottom,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 6,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  AssetImage('assets/images/school.png'),
                            ),
                            // CircleAvatar(
                            //   radius: 30,
                            //   backgroundImage: NetworkImage(
                            //       'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
                            // ),
                            SizedBox(width: 16.0),
                            // Adjust the spacing between the avatar and the username
                            Text(
                              'Keifo Primary School',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Ionicons.ios_alert,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                    controller: Controller,
                    decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.search),
                        hintText: 'Search Parent Here',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.white70))),
                    onChanged: searchParent
                    // searchStudent,
                    ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: parentss.length,
                  itemBuilder: (context, index) {
                    return ParentCard(
                      firstName: parentss[index]['fname'] ?? '',
                      lastName: parentss[index]['lname'] ?? '',
                      email: parentss[index]['email'] ?? '',
                      phone: parentss[index]['phone'] ?? '078566311',
                      profilepicture: parentss[index]['profilepicture'] ?? '',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ParentStudentListView(
                              parentId: parentss[index]['mysqlId'],
                              firstName: parentss[index]['fname'],
                              lastName: parentss[index]['lname'],
                              email: parentss[index]['email'],
                              profilepicture: parentss[index]['profilepicture'],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                //**************************************************************************
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchParent(String query) {
    setState(() {
      if (query.isEmpty) {
        // If the query is empty, show all students
        fetchParentss();
      } else {
        parentss = parentss.where((parent) {
          final parentName = parent['fname'] as String? ?? '';
          final input = query.toLowerCase();
          if (parentName != null) {
            return parentName.toLowerCase().contains(input);
          } else {
            return false; // Handle null values if needed
          }
        }).toList();
      }
    });
  }
// void searchParent(String query) {
//   setState(() {
//     if (query.isEmpty) {
//       // If the query is empty, show all parents
//       fetchParentsFB();
//     } else {
//       parentsFB = parentsFB.where((parent) {
//         final parentName = '${parent.fname} ${parent.lname}'.toLowerCase();
//         final input = query.toLowerCase();
//         return parentName.contains(input);
//       }).toList();
//     }
//   });
// }
}
