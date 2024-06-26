// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:schoolbassapp/models/fireBaseModels/gurdisanfb.dart';
// import 'package:schoolbassapp/models/gurdian.dart';
// import 'package:schoolbassapp/services/Gurdian_apiService.dart';
// import 'package:schoolbassapp/services/Trip_apiService.dart';
// import 'package:schoolbassapp/ui/bucket01/trip_page.dart';
// import 'package:schoolbassapp/style/theme.dart' as Theme;
//
// class ProfilePicDialogBox extends StatefulWidget {
//
//     final int tripRecordId;
//   final String fingerPrintId;
//
//   ProfilePicDialogBox({
//     required this.tripRecordId,
//     required this.fingerPrintId,
//   });
//
//
//   @override
//   State<ProfilePicDialogBox> createState() => _ProfilePicDialogBoxState();
// }
//
// class _ProfilePicDialogBoxState extends State<ProfilePicDialogBox> {
//
//   TripApiService apiService = TripApiService();
//   bool _isLoading = true;
//
//   int? id;
//   String? _fname;
//   String? _lname;
//   String? _phone;
//   String? _email;
//   String? _profilepicture;
//   String? _digitalfingerprint;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchGurdianDetails();
//   }
//
//   void _fetchGurdianDetails() async {
//     final apiService = GardianApiService();
//     final Gurdian gurdian = await apiService.getUserFromPrefs();
//     setState(() {
//       id = gurdian.id;
//       _fname = gurdian.fname;
//       _lname = gurdian.lname;
//       _phone = gurdian.phone;
//       _email = gurdian.email;
//       _profilepicture = gurdian.profilepicture;
//       _digitalfingerprint = gurdian.digitalfingerprint;
//     });
//
//     print("shared prefferency test $id");
//   }
//
//   void _onPressed(BuildContext context) async {
//     final Tripid = widget.tripRecordId;
//
//     try {
//       await apiService.updateTripRecordById(Tripid, id!, context);
//       print('Trip Record updated successfully');
//
//       // Navigate only if the update is successful
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => Buck01Class(realTripID: Tripid,),
//         ),
//       );
//     } catch (e) {
//       print('Error updating trip record: $e');
//       // Handle the error if needed
//     }
//   }
//
//
//   /////////////////*************************************
//     Future<void> getUserByFingerprint() async {
//     try {
//       QuerySnapshot querySnapshot = await FirebaseFirestore.instance
//           .collection('guardians')
//           .where('digitalfingerprint', isEqualTo: widget.fingerPrintId)
//           .limit(1)
//           .get();
//
//       if (querySnapshot.docs.isNotEmpty) {
//         DocumentSnapshot snapshot = querySnapshot.docs.first;
//         GurdianFB gurdian =
//             GurdianFB.fromJson(snapshot.data() as Map<String, dynamic>);
//
//         setState(() {
//           id = gurdian.mysqlId;
//           _fname = gurdian.fname;
//           _lname = gurdian.lname;
//           _phone = gurdian.phone;
//           _email = gurdian.email;
//           _profilepicture = gurdian.profilepicture;
//           _digitalfingerprint = gurdian.digitalfingerprint;
//           _isLoading = false; // Set loading state to false
//         });
//       } else {
//         print('Gurdianid:::{$id}');
//         setState(() {
//           _isLoading = false; // Set loading state to false
//         });
//       }
//     } catch (e) {
//       print('Error getting user by fingerprint: $e');
//       setState(() {
//         _isLoading = false; // Set loading state to false
//       });
//     }
//   }
//
//   //////////////////////**************************************
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       content: Container(
//         width: 300,
//         height: 220,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Container(
//                         width: 64, // Specify width
//                         height: 64,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           image: DecorationImage(
//                             image: Image.memory(
//                               base64Decode(_profilepicture!),
//                               fit: BoxFit.cover,
//                             ).image,
//                             fit: BoxFit.cover,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 2),
//                     // Adjust the spacing between avatar and text
//                     Text(
//                       " $_fname" ?? 'Loading...',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     // Adjust the spacing between name and email
//                     Text(
//                       " $_email" ?? 'Loading...',
//                       style: TextStyle(
//                         fontSize: 14,
//                         color: Colors.grey,
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 10.0),
//                       decoration: new BoxDecoration(
//                         borderRadius: BorderRadius.all(
//                           Radius.circular(5.0),
//                         ),
//                         boxShadow: <BoxShadow>[
//                           BoxShadow(
//                             color: Theme.Colors.loginGradientStart,
//                             offset: Offset(1.0, 6.0),
//                             blurRadius: 20.0,
//                           ),
//                           BoxShadow(
//                             color: Theme.Colors.loginGradientEnd,
//                             offset: Offset(1.0, 6.0),
//                             blurRadius: 20.0,
//                           ),
//                         ],
//                         gradient: new LinearGradient(
//                           colors: [
//                             Theme.Colors.loginGradientEnd,
//                             Theme.Colors.loginGradientStart
//                           ],
//                           begin: const FractionalOffset(0.2, 0.2),
//                           end: const FractionalOffset(1.0, 1.0),
//                           stops: [0.0, 1.0],
//                           tileMode: TileMode.clamp,
//                         ),
//                       ),
//                       child: MaterialButton(
//                         highlightColor: Colors.transparent,
//                         splashColor: Theme.Colors.loginGradientEnd,
//                         //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(
//                             vertical: 10.0,
//                             horizontal: 42.0,
//                           ),
//                           child: Text(
//                             "Next",
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 25.0,
//                               fontFamily: "WorkSansBold",
//                             ),
//                           ),
//                         ),
//                         //update inssert gurdian value on trip record with id tripRecordId
//                         //also go to bucket01Class
//                         onPressed: () => _onPressed(context),
//                         //***************************************
//
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/custom_material_button.dart';

import '../core/models/class.dart';
import '../core/models/fireBaseModels/studentfb.dart';
import '../core/models/station.dart';
import '../core/services/Class_apiService.dart';
import '../core/services/Station_apiService.dart';
import '../core/services/Trip_apiService.dart';
import '../ui/trip_pages/trip_page.dart';
import 'custom_snackbar.dart';
import 'loading_dialog.dart';

class ProfilePicDialogBoxStudent extends StatefulWidget {
  final int tripRecordId;
  final String fingerPrintId;
  final String action;

  ProfilePicDialogBoxStudent({
    required this.tripRecordId,
    required this.fingerPrintId,
    required this.action,
  });

  @override
  State<ProfilePicDialogBoxStudent> createState() =>
      _ProfilePicDialogBoxStudentState();
}

class _ProfilePicDialogBoxStudentState
    extends State<ProfilePicDialogBoxStudent> {
  bool _isLoading = true;

  TripApiService apiService = TripApiService();
  int? _id;
  int studentId = 0;
  String? _fname;
  String? _lname;
  int? _classId;
  int? _stationId;
  String? _registrationNumber;
  int? _age;
  String? _profilepicture;
  String? _digitalfingerprint;
  String? stationName;
  String? className;
  DateTime? _timestamp;

  @override
  void initState() {
    super.initState();
    getUserByFingerprint();
  }

  Future<void> addStudentTripList(BuildContext context) async {
    final Tripid = widget.tripRecordId;
    final fingerPrintId = widget.fingerPrintId;
    if (kDebugMode) {
      print('student mysqlid:::::::${_id}');
    }

    try {
      await apiService.addStudentTripList(
        Tripid,
        _id!,
      );
      // getUserByFingerprint();

      // Navigate only if the update is successful

      Navigator.pop(context);
      customSnackBar(context, 'Success', Colors.green);
    } catch (e) {
      if (kDebugMode) {
        print('Error updating trip record: $e');
        customSnackBar(context, e.toString(), Colors.red);
      }
      // Handle the error if needed
    }
  }

  Future<void> dropStudent() async {
    loadingDialog(context);
    bool result =
        await apiService.dropStudent(widget.tripRecordId ?? 0, studentId);
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
    Navigator.pop(context);
    if (result) {
      customSnackBar(context, "Success", Colors.green);
    } else {
      customSnackBar(context, "Failed: An error occurred.", Colors.red);
    }
  }

  Future<void> getUserByFingerprint() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('students')
          .where('digitalfingerprint', isEqualTo: widget.fingerPrintId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        StudentFB student =
            StudentFB.fromJson(snapshot.data() as Map<String, dynamic>);
        studentId = student.mysqlId ?? 0;

        // Retrieve class details from ClassApiService
        List<Class>? classDetailsList = await getClassDetails(student.class_id);
        Class? classDetails;

        if (classDetailsList != null && classDetailsList.isNotEmpty) {
          classDetails = classDetailsList.first;
        } else {
          // Handle the case where no class details are found
          print('Class details not found');
        }
        if (classDetails != null) {
          // Print all class details
          print('Class ID: ${classDetails.id ?? 'N/A'}');
          print('Class Code: ${classDetails.code ?? 'N/A'}');
          print('Class Name: ${classDetails.name ?? 'N/A'}');
          print('Class Capacity: ${classDetails.capacity ?? 'N/A'}');
          print('Class Timestamp: ${classDetails.timestamp ?? 'N/A'}');
        } else {
          print('Class not found');
        }

        // Retrieve station details from StationApiService
        Station? stationDetails = await getStationDetails(student.station_id);

        if (stationDetails != null) {
          // Print all station details
          print('Station ID: ${stationDetails.id}');
          print('Station Code: ${stationDetails.code}');
          print('Station Name: ${stationDetails.name}');
          print('Station Timestamp: ${stationDetails.timestamp}');
        } else {
          print('Station not found');
        }

        setState(() {
          // Update state variables with student data
          _id = student.mysqlId;
          _fname = student.fname;
          _lname = student.lname;
          _classId = student.class_id;
          _stationId = student.station_id;
          _registrationNumber = student.registration_number;
          _age = student.age;
          _profilepicture = student.profilepicture;
          _digitalfingerprint = student.digitalfingerprint;
          _timestamp = student.timestamp;
          // Check if classDetails and stationDetails are not null before accessing their properties
          className = classDetails != null ? classDetails.name ?? 'N/A' : 'N/A';
          stationName =
              stationDetails != null ? stationDetails.name ?? 'N/A' : 'N/A';
          _isLoading = false; // Set loading state to false
        });
      } else {
        print('Student not found');
        setState(() {
          _isLoading = false; // Set loading state to false
        });
      }
    } catch (e) {
      print('Error getting user by fingerprint: $e');
      setState(() {
        _isLoading = false; // Set loading state to false
      });
    }
  }

  Future<List<Class>?> getClassDetails(int? classId) async {
    if (classId == null) return null; // Return null if classId is null

    try {
      // Use ClassApiService to fetch class details by ID
      List<Class>? classList = await ClassApiService().getClassById(classId);

      if (classList != null && classList.isNotEmpty) {
        return classList;
      } else {
        if (kDebugMode) {
          print('Class not found');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting class details: $e');
      }
      return null;
    }
  }

  Future<Station?> getStationDetails(int? stationId) async {
    if (stationId == null) return null; // Return null if stationId is null

    try {
      // Use StationApiService to fetch station details by ID
      List<Station>? stationList =
          await StationApiService().getStationById(stationId);

      Station? stationDetails;
      if (stationList != null && stationList.isNotEmpty) {
        stationDetails = stationList.first;
      } else {
        if (kDebugMode) {
          print('Station not found');
        }
      }

      return stationDetails; // Return the station details
    } catch (e) {
      if (kDebugMode) {
        print('Error getting station details: $e');
      }
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const SpinKitWave(
            color: Colors.white,
          )
        : AlertDialog(
            content: SizedBox(
              width: 300,
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: _profilepicture != null
                                  ? DecorationImage(
                                      image: MemoryImage(
                                        base64Decode(_profilepicture!),
                                      ),
                                      fit: BoxFit.cover,
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '$_fname $_lname' ?? 'Loading...',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          stationName ?? 'Loading...',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        CustomMaterialButton(
                          label: "Finish",
                          onPressed: () => widget.action == "drop"
                              ? dropStudent()
                              : addStudentTripList(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
