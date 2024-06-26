import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/ui/message/message_page.dart';
import 'package:newschoolbusapp/ui/trip_pages/students_attendance_page.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/fingerprintAlertDialogStudent.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';

import '../../core/controllers/trip_controller.dart';
import '../../core/models/TripRecordClass.dart';
import '../../core/models/gurdian.dart';
import '../../core/services/Gurdian_apiService.dart';
import '../../core/services/Trip_apiService.dart';
import '../../core/services/fingerPrint_ApiService.dart';
import '../../widgets/profiliPictureDialogBoxStudent.dart';

class TripPage extends StatefulWidget {
  final int? realTripID;

  const TripPage({super.key, required this.realTripID});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  final TripApiService _apiService = TripApiService();
  String? description;
  String? tripStatus;
  int? weekof;
  DateTime? time;
  late TripController tripController;
  late FingerPrintApiService _fingerPrintApiService;

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
    retrieveTripRecords();
    _fetchGuardianDetails();
    tripController = TripController();
    _fingerPrintApiService = FingerPrintApiService();
  }

  void _fetchGuardianDetails() async {
    final apiService = GardianApiService();
    final Gurdian guardian = await apiService.getUserFromPrefs();
    setState(() {
      id = guardian.id;
      _fname = guardian.fname;
      _lname = guardian.lname;
      _phone = guardian.phone;
      _email = guardian.email;
      _profilepicture = guardian.profilepicture;
      _digitalfingerprint = guardian.digitalfingerprint;
    });

    if (kDebugMode) {
      print("shared preference test $id");
    }
  }

  Future<void> retrieveTripRecords() async {
    final int tripId = widget.realTripID ?? 0;

    final List<TripRecord>? tripRecords =
        await _apiService.getTripRecordById(tripId);

    if (tripRecords != null && tripRecords.isNotEmpty) {
      final TripRecord tripRecord = tripRecords.first;
      setState(() {
        description = tripRecord.description;
        tripStatus = tripRecord.tripStatus;
        weekof = tripRecord.weekOf;
        time = tripRecord.timestamp;
      });

      if (kDebugMode) {
        print('Trip Record ID: ${tripRecord.id}');
        print('Bus ID: ${tripRecord.busId}');
        print('Route ID: ${tripRecord.routeId}');
        print('Guardian ID: ${tripRecord.guardianId}');
        print('Description: ${tripRecord.description}');
        print('Trip Status: ${tripRecord.tripStatus}');
        print('Week Of: ${tripRecord.weekOf}');
        print('Timestamp: ${tripRecord.timestamp}');
      }
    } else {
      if (kDebugMode) {
        print('Trip records not found');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get current date and time
    DateTime now = DateTime.now();

    // Format time in HH:mm format (24-hour)
    String formattedTime = DateFormat.Hm().format(now);

    // Format date in dd MMMM yyyy format (e.g., 27 December 2023)
    String formattedDate = DateFormat('dd MMMM yyyy').format(now);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 6,
                                child: Container(
                                  color: Colors.white,
                                  child: const Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'),
                                      ),
                                      SizedBox(width: 16.0),
                                      Text(
                                        'Keifo Primary School',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(formattedTime,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text(formattedDate,
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                    Text("Welcome $_fname",
                                        style: const TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.linearTop,
                        AppColors.linearMiddle,
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        description ?? '',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // Add more widgets here
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    CustomMaterialButton(
                      label: "Add Student",
                      onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return FingerPrintAlertDialogButtonStudent(
                            realTripID: widget.realTripID,
                          );
                        },
                      ),
                    ),
                    CustomMaterialButton(
                      label: "Drop Student",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            _fingerPrintApiService
                                .getFingerprintID()
                                .then((response) async {
                              if (response != null) {
                                // ---------********************
                                // ---------********************

                                int fingerprintStudentId = int.parse(response);

                                loadingDialog(context);

                                if (mounted) {
                                  Navigator.pop(context);
                                  Navigator.pop(context);

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        ProfilePicDialogBoxStudent(
                                      fingerPrintId:
                                          fingerprintStudentId.toString(),
                                      tripRecordId: widget.realTripID!,
                                      action: "drop",
                                    ),
                                  );
                                }

                                // ---------********************
                                // ---------********************
                              } else {
                                Navigator.pop(context);
                                customSnackBar(context,
                                    "Fingerprint not found.", Colors.red);
                              }
                            }).catchError((error) {
                              customSnackBar(
                                context,
                                error.toString(),
                                Colors.red,
                              );
                            });

                            return AlertDialog(
                              title: const Text("Scan Fingerprint"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                      "Press your Finger for two (2) seconds to capture your fingerprint."),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    height: 50,
                                    width: 50,
                                    child: Image.network(
                                      'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ionicons_finger-print-sharp.svg/640px-Ionicons_finger-print-sharp.svg.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
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
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "OK",
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
                    ),
                    CustomMaterialButton(
                      label: "Send Emergency Message",
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MessageEditorPage(
                              tripId: widget.realTripID!,
                            ),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => Bucket02(
                        //       tripId: widget.realTripID!,
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                    CustomMaterialButton(
                      label: "View Attendance",
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentAttendancePage(
                            tripId: widget.realTripID!,
                          ),
                        ),
                      ),
                    ),
                    CustomMaterialButton(
                      label: "Finish Trip",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Finish Trip"),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Are you sure you want to end this trip?"),
                                  SizedBox(height: 20),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    loadingDialog(context);
                                    bool result = await tripController
                                        .endTrip(widget.realTripID ?? 0);
                                    if (mounted) {
                                      Navigator.pop(context);
                                      if (result) {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        customSnackBar(
                                          context,
                                          "Success",
                                          Colors.green,
                                        );
                                      } else {
                                        customSnackBar(
                                          context,
                                          "Error: Failed to finish trip.",
                                          Colors.red,
                                        );
                                      }
                                    }
                                  },
                                  child: const Text(
                                    "Yes",
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:icons_flutter/icons_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:schoolbassapp/models/TripRecordClass.dart';
// import 'package:schoolbassapp/services/Trip_apiService.dart';
// import 'package:schoolbassapp/style/theme.dart' as Theme;
// import 'package:schoolbassapp/ui/bucket02/bucket02Class.dart';
// import 'package:schoolbassapp/widgets/FIngerPrintDialogBox.dart';
// import 'package:schoolbassapp/widgets/fingerprintAlertDialogStudent.dart';
//
// class Buck01Class extends StatefulWidget {
//   final int? realTripID;
//
//   const Buck01Class({Key? key,required this.realTripID}) : super(key: key);
//
//   @override
//   State<Buck01Class> createState() => _Buck01ClassState();
// }
//
// class _Buck01ClassState extends State<Buck01Class> {
//
//   final TripApiService _apiService = TripApiService(); // Create an instance of your ApiService
//
//   String? description ;
//   String? tripStatus;
//   int? weekof;
//   int? guardianID;
//   String? guardianName;
//   DateTime? time;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     retrieveTripRecords();
//   }
//
//   void retrieveTripRecords() async {
//     final int tripId = widget.realTripID ?? 0; // Get the trip ID from the widget property
//
//     // Call the API to retrieve the trip records
//     final List<TripRecord>? tripRecords = await _apiService.getTripRecordById(tripId);
//
//     // Check if tripRecords is not null and not empty
//     if (tripRecords != null && tripRecords.isNotEmpty) {
//       // Iterate over the list of trip records
//       for (TripRecord tripRecord in tripRecords) {
//
//         setState(() {
//           description = tripRecord.description;
//           tripStatus =  tripRecord.tripStatus;
//           weekof = tripRecord.weekOf;
//           time = tripRecord.timestamp;
//         });
//
//         print('Trip Record ID: ${tripRecord.id}');
//         print('Bus ID: ${tripRecord.busId}');
//         print('Route ID: ${tripRecord.routeId}');
//         print('Guardian ID: ${tripRecord.guardianId}');
//         print('Description: ${tripRecord.description}');
//         print('Trip Status: ${tripRecord.tripStatus}');
//         print('Week Of: ${tripRecord.weekOf}');
//         print('Timestamp: ${tripRecord.timestamp}');
//       }
//     } else {
//       print('Trip records not found');
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Theme.Colors.loginGradientStart,
//               Theme.Colors.loginGradientEnd,
//             ],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   color: Colors.white,
//                   width: double.infinity,
//                   height: 155,
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Flexible(
//                           flex: 2,
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Flexible(
//                                   flex: 6,
//                                   child: Container(
//                                       color: Colors.white,
//                                       child: Row(
//                                         children: [
//                                           CircleAvatar(
//                                             radius: 30,
//                                             backgroundImage: NetworkImage(
//                                                 'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
//                                           ),
//                                           SizedBox(width: 16.0),
//                                           // Adjust the spacing between the avatar and the username
//                                           Text(
//                                             'Keifo Primary School',
//                                             style: TextStyle(
//                                                 fontSize: 18.0,
//                                                 fontWeight: FontWeight.bold),
//                                           ),
//                                         ],
//                                       )),
//                                 ),
//                                 Flexible(
//                                   flex: 2,
//                                   child: Container(
//                                     //color: Colors.grey,
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Icon(
//                                             Ionicons.ios_search,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Icon(
//                                             Ionicons.ios_alert,
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Container(
//                                   color: Colors.white,
//                                   width: 360,
//                                   height: 90,
//                                   child: Column(
//                                     children: [
//                                       Text("05:20 pm",
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold)),
//                                       Text("27 December 2023",
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold)),
//                                       Text("Wellcome Mr Enock",
//                                           style: TextStyle(
//                                               fontSize: 16.0,
//                                               fontWeight: FontWeight.bold)),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 100,
//             ),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     //  color: Colors.white,
//                     width: double.infinity,
//                     height: 30,
//                     child: Container(
//                       //rcolor: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                               child: Text(
//                             "Wainting ",
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           )),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           Center(
//                               child: SpinKitWave(
//                             color: Colors.greenAccent,
//                           )),
//                           // Center(child: Text("FingerPrint")),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     //  color: Colors.white,
//                     width: double.infinity,
//                     height: 30,
//                     child: Container(
//                       //rcolor: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                               child: Row(
//                             children: [
//                               Text(
//                                 description!,
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                             ],
//                           )),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           // Center(child: Text("FingerPrint")),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     //  color: Colors.white,
//                     width: double.infinity,
//                     height: 30,
//                     child: Container(
//                       //rcolor: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                               child: Row(
//                             children: [
//                               Text(
//                                 "Trip number ${widget.realTripID} ",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                             ],
//                           )),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           // Center(child: Text("FingerPrint")),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     //  color: Colors.white,
//                     width: double.infinity,
//                     height: 30,
//                     child: Container(
//                       //rcolor: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                               child: Row(
//                             children: [
//                               Text(
//                                 "Week of $weekof",
//                                 style: TextStyle(
//                                     color: Colors.white, fontSize: 18),
//                               ),
//                             ],
//                           )),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           // Center(child: Text("FingerPrint")),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//             Padding(
//                 padding: const EdgeInsets.only(
//                     top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     //  color: Colors.white,
//                     width: double.infinity,
//                     height: 30,
//                     child: Container(
//                       //rcolor: Colors.white,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Center(
//                               child: Row(
//                             children: [
//                               Text(
//                                  DateFormat('dd MMMM yyyy').format(time!),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ],
//                           )),
//                           SizedBox(
//                             width: 2,
//                           ),
//                           // Center(child: Text("FingerPrint")),
//                         ],
//                       ),
//                     ),
//                   ),
//                 )),
//             Container(
//               margin: EdgeInsets.only(top: 50.0),
//               decoration: new BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: Theme.Colors.loginGradientStart,
//                     offset: Offset(1.0, 6.0),
//                     blurRadius: 20.0,
//                   ),
//                   BoxShadow(
//                     color: Theme.Colors.loginGradientEnd,
//                     offset: Offset(1.0, 6.0),
//                     blurRadius: 20.0,
//                   ),
//                 ],
//                 gradient: new LinearGradient(
//                     colors: [
//                       Theme.Colors.loginGradientEnd,
//                       Theme.Colors.loginGradientStart
//                     ],
//                     begin: const FractionalOffset(0.2, 0.2),
//                     end: const FractionalOffset(1.0, 1.0),
//                     stops: [0.0, 1.0],
//                     tileMode: TileMode.clamp),
//               ),
//               child: MaterialButton(
//                 highlightColor: Colors.transparent,
//                 splashColor: Theme.Colors.loginGradientEnd,
//                 //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 10.0, horizontal: 42.0),
//                   child: Text(
//                     "Add Student",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 25.0,
//                         fontFamily: "WorkSansBold"),
//                   ),
//                 ),
//                 onPressed: () => showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return Container(
//                       child: FingerPrintAlertDialogButtonStudent(
//                           realTripID: widget.realTripID),
//                     );
//                   },
//                 )
//                 //     Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => Bucket02()),
//                 // ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
