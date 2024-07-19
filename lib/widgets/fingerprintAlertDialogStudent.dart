import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';

// import 'package:google_fonts/google_fonts.dart';
import 'package:newschoolbusapp/widgets/profiliPictureDialogBoxStudent.dart';

import '../core/services/fingerPrint_ApiService.dart';

class FingerPrintAlertDialogButtonStudent extends StatefulWidget {
  final int? realTripID;

  const FingerPrintAlertDialogButtonStudent({super.key, this.realTripID});

  @override
  _FingerPrintAlertDialogButtonStudentState createState() =>
      _FingerPrintAlertDialogButtonStudentState();
}

class _FingerPrintAlertDialogButtonStudentState
    extends State<FingerPrintAlertDialogButtonStudent> {
  String? fingerPrintId;
  bool isLoading = false;

  @override
  void initState() {
    _handleButtonTap();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    AppColors.linearTop,
                    AppColors.linearBottom,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              // color: Colors.black,
              child: GestureDetector(
                onTap: isLoading ? null : _handleButtonTap,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        isLoading
                            ? "Waiting..."
                            : "Click to Add FingerPrint. Device is Active.",
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleButtonTap() async {
    setState(() {
      isLoading = true;
    });

    try {
      fingerPrintId = await FingerPrintApiService().getFingerprintID();

      if (fingerPrintId != null) {
        if (kDebugMode) {
          print('Fingerprint Student ID: $fingerPrintId');
        }
        if (!mounted) {
          return;
        }
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => ProfilePicDialogBoxStudent(
            fingerPrintId: fingerPrintId!,
            tripRecordId: widget.realTripID!,
            action: "add",
          ),
        );
      } else {
        if (kDebugMode) {
          print('Failed to retrieve fingerprint ID');
        }
        // Handle the case where the fingerprint ID couldn't be retrieved
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error retrieving fingerprint ID: $error');
      }
      // Handle error appropriately, e.g., show a snackbar
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:schoolbassapp/services/fingerPrint_ApiService.dart';
// import 'package:schoolbassapp/widgets/profilePictDialogBox.dart';
//
// class FingerPrintAlertDialogButtonStudent extends StatefulWidget {
//   final int? realTripID;
//
//   FingerPrintAlertDialogButtonStudent({Key? key, this.realTripID})
//       : super(key: key);
//
//   @override
//   State<FingerPrintAlertDialogButtonStudent> createState() =>
//       _FingerPrintAlertDialogButtonStudentState();
// }
//
// class _FingerPrintAlertDialogButtonStudentState
//     extends State<FingerPrintAlertDialogButtonStudent> {
//   String? fingerPrintId;
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Container(
//           height: MediaQuery.of(context).size.width,
//             width: MediaQuery.of(context).size.width,
//           child: GestureDetector(
//             onTap: () async {
//               setState(() {
//                 isLoading = true; // Set loading state to true when button is tapped
//               });
//
//               try {
//                 // Call the getFingerprintID method when the button is pressed
//                 fingerPrintId = await FingerPrintApiService.getFingerprintID();
//
//                 // Handle the retrieved fingerprint ID as needed
//                 if (fingerPrintId != null) {
//                   print('Fingerprint ID: $fingerPrintId');
//                   // Do something with the fingerprint ID, like navigating to another screen
//                 } else {
//                   print('Failed to retrieve fingerprint ID');
//                   // Handle the case where the fingerprint ID couldn't be retrieved
//                 }
//               } catch (error) {
//                 print('Error retrieving fingerprint ID: $error');
//                 // Handle error appropriately, e.g., show a snackbar
//               } finally {
//                 setState(() {
//                   isLoading =
//                       false; // Set loading state to false when operation completes
//                 });
//
//                 // Show dialog only if fingerprint ID is retrieved successfully
//                 if (fingerPrintId != null) {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Container(
//                         child: ProfilePicDialogBox(
//                           fingerPrintId: fingerPrintId!,
//                           tripRecordId: widget.realTripID!,
//                         ),
//                       );
//                     },
//                   );
//                 }
//               }
//             },
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 isLoading
//                     ? "Loading..."
//                     : "Click to Add FingerPrint Device is Active ! Has:trpId :${widget.realTripID} ",
//                 style: TextStyle(
//                   color: isLoading ? Colors.grey : Colors.blue,
//                   decoration: isLoading ? null : TextDecoration.underline,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
