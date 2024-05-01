import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newschoolbusapp/services/fingerPrint_ApiService.dart';
import 'package:newschoolbusapp/widgets/profilePictDialogBox.dart';
import 'package:newschoolbusapp/widgets/profiliPictureDialogBoxStudent.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class FingerPrintAlertDialogButtonStudent extends StatefulWidget {
  final int? realTripID;

  const FingerPrintAlertDialogButtonStudent({Key? key, this.realTripID})
      : super(key: key);

  @override
  _FingerPrintAlertDialogButtonStudentState createState() =>
      _FingerPrintAlertDialogButtonStudentState();
}

class _FingerPrintAlertDialogButtonStudentState
    extends State<FingerPrintAlertDialogButtonStudent> {
  String? fingerPrintId;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // Theme.Colors.loginGradientStart,
                  Colors.blueAccent,
                  Colors.blueAccent,
                 Colors.black
                 // Theme.Colors.loginGradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
           // color: Colors.black,
            child: GestureDetector(
              onTap: isLoading ? null : _handleButtonTap,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isLoading
                        ? "Waiting..."
                        : "Click to Add FingerPrint , Device is Active ! Has:trpId :${widget.realTripID} ",
                    style: GoogleFonts.openSans( // Example font, replace with your desired Google Font
                      fontSize: 20,
                      color: isLoading ? Colors.white : Colors.white,
                    //  decoration: isLoading ? null : TextDecoration.underline,
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
      fingerPrintId = await FingerPrintApiService.getFingerprintID();

      if (fingerPrintId != null) {
        print('Fingerprint Student ID: $fingerPrintId');
        showDialog(
          context: context,
          builder: (BuildContext context) => ProfilePicDialogBoxStudent(
            fingerPrintId: fingerPrintId!,
            tripRecordId: widget.realTripID!,
          ),
        );
      } else {
        print('Failed to retrieve fingerprint ID');
        // Handle the case where the fingerprint ID couldn't be retrieved
      }
    } catch (error) {
      print('Error retrieving fingerprint ID: $error');
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
