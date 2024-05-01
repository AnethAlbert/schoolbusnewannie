import 'package:flutter/material.dart';
import 'package:newschoolbusapp/services/fingerPrint_ApiService.dart';
import 'package:newschoolbusapp/widgets/profilePictDialogBox.dart';

class FingerPrintAlertDialogButton extends StatefulWidget {
  final int? realTripID;

  FingerPrintAlertDialogButton({Key? key, this.realTripID}) : super(key: key);

  @override
  State<FingerPrintAlertDialogButton> createState() =>
      _FingerPrintAlertDialogButtonState();
}

class _FingerPrintAlertDialogButtonState
    extends State<FingerPrintAlertDialogButton> {
  String? fingerPrintId;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {
          isLoading = true; // Set loading state to true when button is tapped
        });

        try {
          // Call the getFingerprintID method when the button is pressed
          fingerPrintId = await FingerPrintApiService.getFingerprintID();

          // Handle the retrieved fingerprint ID as needed
          if (fingerPrintId != null) {
            print('Fingerprint ID: $fingerPrintId');
            // Do something with the fingerprint ID, like navigating to another screen
          } else {
            print('Failed to retrieve fingerprint ID');
            // Handle the case where the fingerprint ID couldn't be retrieved
          }
        } catch (error) {
          print('Error retrieving fingerprint ID: $error');
          // Handle error appropriately, e.g., show a snackbar
        } finally {
          setState(() {
            isLoading = false; // Set loading state to false when operation completes
          });

          // Show dialog only if fingerprint ID is retrieved successfully
          if (fingerPrintId != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: ProfilePicDialogBox(
                    fingerPrintId: fingerPrintId!,
                    tripRecordId: widget.realTripID!,
                  ),
                );
              },
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          isLoading
              ? "Loading..."
              : "Click to Add FingerPrint Device is Active ! Has:trpId :${widget.realTripID} ",
          style: TextStyle(
            color: isLoading ? Colors.grey : Colors.blue,
          ),

        ),
      ),
    );
  }
}


//
// import 'package:flutter/material.dart';
// import 'package:schoolbassapp/models/route.dart';
// import 'package:schoolbassapp/services/Trip_apiService.dart';
// import 'package:schoolbassapp/services/fingerPrint_ApiService.dart';
// import 'package:schoolbassapp/widgets/profilePictDialogBox.dart';
//
// class FingerPrintAlertDialogButton extends StatefulWidget {
//   final int? realTripID; // Updated to match the variable name
//
//   FingerPrintAlertDialogButton({Key? key, this.realTripID}) : super(key: key);
//
//   @override
//   State<FingerPrintAlertDialogButton> createState() =>
//       _FingerPrintAlertDialogButtonState();
// }
//
// class _FingerPrintAlertDialogButtonState
//     extends State<FingerPrintAlertDialogButton> {
//
//   String? fingerPrintId;
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: Text("To school "),
//               content: Container(
//                 width: 300,
//                 height: 200,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: Text("Add Signature"),
//                     ),
//                     Container(
//                       height: 160,
//                       width: 200,
//                       child: Center(
//                         child: Image.network(
//                           'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ionicons_finger-print-sharp.svg/640px-Ionicons_finger-print-sharp.svg.png',
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text("Cancel"),
//                 ),
//                 TextButton(
//                   onPressed: () async {
//                     ////////////////////
//                     // Call the getFingerprintID method when the button is pressed
//                     fingerPrintId =
//                         await FingerPrintApiService.getFingerprintID();
//
//                     // Handle the retrieved fingerprint ID as needed
//                     if (fingerPrintId != null) {
//                       print('Fingerprint ID: $fingerPrintId');
//                       // Do something with the fingerprint ID, like navigating to another screen
//                     } else {
//                       print('Failed to retrieve fingerprint ID');
//                       // Handle the case where the fingerprint ID couldn't be retrieved
//                     }
//                     /////////////////////
//                     print("fingerprintClassprint : TRIPID=${widget.realTripID}");
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return Container(
//                           child: ProfilePicDialogBox(
//                             fingerPrintId:fingerPrintId!,
//                             tripRecordId: widget.realTripID!,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   child: Text("ok ${widget.realTripID}"),
//                 ),
//
//                 TextButton(
//                   onPressed: () async {
//                     // Call the getFingerprintID method when the button is pressed
//                     String? fingerprintID =
//                     await FingerPrintApiService.getFingerprintID();
//
//                     // Handle the retrieved fingerprint ID as needed
//                     if (fingerprintID != null) {
//                       print('Fingerprint ID: $fingerprintID');
//                       // Do something with the fingerprint ID, like navigating to another screen
//                     } else {
//                       print('Failed to retrieve fingerprint ID');
//                       // Handle the case where the fingerprint ID couldn't be retrieved
//                     }
//                   },
//                   child: Text('ok ${widget.realTripID}'),
//                 ),
//               ],
//             );
//           },
//         );
//       },
//       child: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Text(
//           "Click to Add FingerPrint Device is Active ! Has:trpId :${widget.realTripID} ",
//           style: TextStyle(
//             color: Colors.blue,
//             decoration: TextDecoration.underline,
//           ),
//         ),
//       ),
//     );
//   }
// }
