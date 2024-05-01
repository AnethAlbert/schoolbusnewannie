import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:newschoolbusapp/models/TripRecordClass.dart';
import 'package:newschoolbusapp/models/gurdian.dart';
import 'package:newschoolbusapp/services/Gurdian_apiService.dart';
import 'package:newschoolbusapp/services/Trip_apiService.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/bucket02/bucket02Class.dart';
import 'package:newschoolbusapp/widgets/FIngerPrintDialogBox.dart';
import 'package:newschoolbusapp/widgets/fingerprintAlertDialogStudent.dart';
import 'package:intl/intl.dart';

class Buck01Class extends StatefulWidget {
  final int? realTripID;

  const Buck01Class({Key? key, required this.realTripID}) : super(key: key);

  @override
  State<Buck01Class> createState() => _Buck01ClassState();
}

class _Buck01ClassState extends State<Buck01Class> {
  final TripApiService _apiService = TripApiService();
  String? description;
  String? tripStatus;
  int? weekof;
  DateTime? time;

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
    _fetchGurdianDetails();
  }

  void _fetchGurdianDetails() async {
    final apiService = GardianApiService();
    final Gurdian gurdian = await apiService.getUserFromPrefs();
    setState(() {
      id = gurdian.id;
      _fname = gurdian.fname;
      _lname = gurdian.lname;
      _phone = gurdian.phone;
      _email = gurdian.email;
      _profilepicture = gurdian.profilepicture;
      _digitalfingerprint = gurdian.digitalfingerprint;
    });

    print("shared prefferency test $id");
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

      print('Trip Record ID: ${tripRecord.id}');
      print('Bus ID: ${tripRecord.busId}');
      print('Route ID: ${tripRecord.routeId}');
      print('Guardian ID: ${tripRecord.guardianId}');
      print('Description: ${tripRecord.description}');
      print('Trip Status: ${tripRecord.tripStatus}');
      print('Week Of: ${tripRecord.weekOf}');
      print('Timestamp: ${tripRecord.timestamp}');
    } else {
      print('Trip records not found');
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 155,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Flexible(
                          //  flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 6,
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
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
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: Colors.white,
                                    width: 300,
                                    height: 90,
                                    child: Column(
                                      children: [
                                        Text(formattedTime,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                        Text(formattedDate,
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                        Text("Wellcome $_fname" ?? 'Loading...',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart,
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Waiting ",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 2),
                      SpinKitWave(color: Colors.greenAccent),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Container(
                  width: double.infinity,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart,
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        description ?? '',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              // Add more widgets here
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return FingerPrintAlertDialogButtonStudent(
                      realTripID: widget.realTripID,
                    );
                  },
                ),
                child: Text(
                  "Add Student",
                  style: TextStyle(fontSize: 25.0),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Theme.Colors.loginGradientEnd,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Bucket02(
                      tripId:widget.realTripID!,
                    )),
                  ),
                  //     showDialog(
                  //   context: context,
                  //   builder: (BuildContext context) {
                  //     return FingerPrintAlertDialogButtonStudent(
                  //       realTripID: widget.realTripID,
                  //     );
                  //   },
                  // ),
                  child: Text(
                    "Send Notification",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.Colors.loginGradientEnd,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bucket02(
                          tripId:widget.realTripID!,
                        )),
                      ),
                  child: Text(
                    "Attendacy",
                    style: TextStyle(fontSize: 25.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.Colors.loginGradientEnd,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
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
