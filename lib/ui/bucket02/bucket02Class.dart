import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/ui/bucketliveMap03/BucketMap03.dart';
import 'package:newschoolbusapp/ui/live/mapPage.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';
import 'package:newschoolbusapp/widgets/bottomNavigationClass.dart';
import 'package:newschoolbusapp/widgets/studentCard.dart';
import 'package:newschoolbusapp/widgets/studentCardAttendacy.dart';

import '../../core/services/Trip_apiService.dart';

class Bucket02 extends StatefulWidget {
  final int tripId;

  const Bucket02({Key? key, required this.tripId}) : super(key: key);

  @override
  State<Bucket02> createState() => _Bucket02State();
}

class _Bucket02State extends State<Bucket02> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    StartTripPage(),
    StartTripPage(),
    StartTripPage(),
    MyProfileGuardian(),
    // MapPage(),
    // ContactScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final Controller = TextEditingController();

  List<Map<String, dynamic>> studentsSearch = [];
  String? selecteStudentSearch;
  String? profilePicture;

  String? studentName;

  @override
  void initState() {
    super.initState();
    // Fetch classes when the widget initializes
    fetchStudent1();
  }

  Future<void> fetchStudent1() async {
    try {
      print('Fetching student IDs for trip ID: ${widget.tripId}');

      // Get reference to the students collection
      CollectionReference studentsRef =
          FirebaseFirestore.instance.collection('students');

      // Fetch student IDs by trip ID using TripApiService
      print('Fetching student IDs from TripApiService...');
      // List<Map<String, dynamic>> studentIdsResponse = (await TripApiService().getStudentIDRecordByTripId(widget.tripId))!;
      List<String>? studentIds =
          await TripApiService().getStudentIDRecordByTripId(widget.tripId);
      if (studentIds != null && studentIds.isNotEmpty) {
        List<int> intStudentIds = studentIds.map(int.parse).toList();
        print("int student idss::: $intStudentIds");
        print('Student IDs found. Fetching students from Firestore...');

        QuerySnapshot studentSnapshot = await studentsRef
            .where(
              'mysqlId',
              whereIn: intStudentIds,
            )
            .get();

        if (studentSnapshot.docs.isNotEmpty) {
          print('Students found in Firestore. Processing data...');

          setState(() {
            // Convert each document's data into a map and add it to the list
            studentsSearch = studentSnapshot.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              profilePicture = data['profilepicture'] ?? '';
              return {
                'id': data['mysqlId'],
                'fname': data['fname'] ?? '',
                'lname': data['lname'] ?? '',
                'class_id': data['class_id'] ?? '',
                'digitalfingerprint': data['digitalfingerprint'] ?? '',
                'firebaseId': data['firebaseId'] ?? '',
                'profilepicture': data['profilepicture'] ?? '',
                'registration_number': data['registration_number'] ?? '',
                'station_id': data['station_id'] ?? '',
                'age': data['age'] ?? 0,
              };
            }).toList();
            selecteStudentSearch =
                studentsSearch.isNotEmpty ? studentsSearch.first['name'] : null;
          });

          // Print student names and IDs
          for (var student in studentsSearch) {
            print(
                'Student ID: ${student['id']}, Name: ${student['fname']} ${student['lname']} (${student['age']})');
          }
        } else {
          print('No students found for the retrieved IDs');
        }
      } else {
        print('No student trip list found for the trip');
      }
    } catch (error) {
      print('Error fetching students: $error');
      // Handle error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                      controller: Controller,
                      decoration: InputDecoration(
                          filled: true,
                          prefixIcon: const Icon(Icons.search),
                          hintText: 'Search Student Here',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide:
                                  const BorderSide(color: Colors.white70))),
                      onChanged: searchStudents
                      // searchStudent,
                      ),
                  SizedBox(height: 10.0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: studentsSearch.length,
                      itemBuilder: (context, index) {
                        return Material(
                          child: StudentCardAttendacy(
                            firstName: studentsSearch[index]['fname'] ?? '',
                            lastName: studentsSearch[index]['fname'] ?? '',
                            age: studentsSearch[index]['age'] ?? '',
                            profilepicture: studentsSearch[index]
                                ['profilepicture'],
                            staionName: '',
                            stationCode: '',
                            onPressed: () {
                              //  print('ID: ${studentsSearch[index]['mysqlId']}');
                              print(
                                  'First Name: ${studentsSearch[index]['fname']}');
                              print(
                                  'Last Name: ${studentsSearch[index]['lname']}');
                              print(
                                  'Class ID: ${studentsSearch[index]['class_id']}');
                              print(
                                  'Digital Fingerprint: ${studentsSearch[index]['digitalfingerprint']}');
                              print(
                                  'Firebase ID: ${studentsSearch[index]['firebaseId']}');
                              //  print('Profile Picture: ${studentsSearch[index]['profilepicture']}');
                              print(
                                  'Registration Number: ${studentsSearch[index]['registration_number']}');
                              print(
                                  'Station ID: ${studentsSearch[index]['station_id']}');
                              print('Age: ${studentsSearch[index]['age']}');

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapPage(
                                    //id: studentsSearch[index]['mysqlId'],
                                    fname: studentsSearch[index]['fname'] ?? '',
                                    lname: studentsSearch[index]['lname'] ?? '',
                                    classId:
                                        studentsSearch[index]['class_id'] ?? '',
                                    digitalFingerprint: studentsSearch[index]
                                            ['digitalfingerprint'] ??
                                        '',
                                    firebaseId: studentsSearch[index]
                                            ['firebaseId'] ??
                                        '',
                                    profilePicture: studentsSearch[index]
                                            ['profilepicture'] ??
                                        '',
                                    registrationNumber: studentsSearch[index]
                                            ['registration_number'] ??
                                        '',
                                    stationId: studentsSearch[index]
                                            ['station_id'] ??
                                        '',
                                    age: studentsSearch[index]['age'] ?? 0,
                                  ),
                                ),
                              );
                            },

                            // studentClass: studentsSearch[index]['Manzese'] ?? 'Manzese',
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        screens: _screens,
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
}
