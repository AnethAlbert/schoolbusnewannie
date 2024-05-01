// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:schoolbassapp/models/fireBaseModels/gurdisanfb.dart';
// import 'package:schoolbassapp/models/gurdian.dart';
// import 'package:schoolbassapp/services/Gurdian_apiService.dart';
// import 'package:schoolbassapp/services/Trip_apiService.dart';
// import 'package:schoolbassapp/ui/bucket01/bucket01Class.dart';
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
import 'package:newschoolbusapp/models/fireBaseModels/gurdisanfb.dart';
import 'package:newschoolbusapp/models/gurdian.dart';
import 'package:newschoolbusapp/services/Gurdian_apiService.dart';
import 'package:newschoolbusapp/services/Trip_apiService.dart';
import 'package:newschoolbusapp/ui/bucket01/bucket01Class.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class ProfilePicDialogBox extends StatefulWidget {
  final int tripRecordId;
  final String fingerPrintId;

  ProfilePicDialogBox({
    required this.tripRecordId,
    required this.fingerPrintId,
  });

  @override
  State<ProfilePicDialogBox> createState() => _ProfilePicDialogBoxState();
}

class _ProfilePicDialogBoxState extends State<ProfilePicDialogBox> {
  bool _isLoading = true;

  TripApiService apiService = TripApiService();
  int? id;
  String? _fname;
  String? _lname;
  String? _phone;
  String? _email;
  String? _profilepicture;
  String? _digitalfingerprint;

  @override
  void initState() {
    super.initState();
    getUserByFingerprint();
    //_fetchGurdianDetails();
  }

  void _onPressed(BuildContext context) async {
    final Tripid = widget.tripRecordId;
    final fingerPrintId = widget.fingerPrintId;
    print('mysqlid:::::::${id}');

    try {
      await apiService.updateTripRecordById(Tripid, id!, context);
      print('Trip Record updated successfully');
      print('ididid:::::::${id}');

     // Navigate only if the update is successful
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Buck01Class(realTripID:Tripid),
        ),
      );
    } catch (e) {
      print('Error updating trip record: $e');
      // Handle the error if needed
    }
  }

  Future<void> getUserByFingerprint() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('guardians')
          .where('digitalfingerprint', isEqualTo: widget.fingerPrintId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot snapshot = querySnapshot.docs.first;
        GurdianFB gurdian =
        GurdianFB.fromJson(snapshot.data() as Map<String, dynamic>);

        setState(() {
          id = gurdian.mysqlId;
          _fname = gurdian.fname;
          _lname = gurdian.lname;
          _phone = gurdian.phone;
          _email = gurdian.email;
          _profilepicture = gurdian.profilepicture;
          _digitalfingerprint = gurdian.digitalfingerprint;
          _isLoading = false; // Set loading state to false

          // Print every value retrieved from Firestore
          print('ID: $id');
          print('First Name: $_fname');
          print('Last Name: $_lname');
          print('Phone: $_phone');
          print('Email: $_email');
        //  print('Profile Picture: $_profilepicture');
          print('Digital Fingerprint: $_digitalfingerprint');
        });
      } else {
        print('Guardian not found New Trable ...');
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


  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SpinKitWave(
            color: Colors.white,
          )
        : AlertDialog(
            content: Container(
              width: 300,
              height: 220,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
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
                          SizedBox(height: 2),
                          Text(
                            _fname ?? 'Loading...',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            _email ?? 'Loading...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              gradient: LinearGradient(
                                colors: [
                                  Theme.Colors.loginGradientEnd,
                                  Theme.Colors.loginGradientStart
                                ],
                                begin: const FractionalOffset(0.2, 0.2),
                                end: const FractionalOffset(1.0, 1.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp,
                              ),
                            ),
                            child: MaterialButton(
                              onPressed: () => _onPressed(context),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 42.0,
                                ),
                                child: Text(
                                  "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
