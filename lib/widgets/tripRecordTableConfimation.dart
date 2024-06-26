import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/FIngerPrintDialogBox.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/Trip_apiService.dart';

class TripRecordConfirmation extends StatefulWidget {
  final Map<String, dynamic> item;
  final String? profilePicture;

  TripRecordConfirmation(this.item, {this.profilePicture});

  @override
  State<TripRecordConfirmation> createState() => _TripRecordConfirmationState();
}

class _TripRecordConfirmationState extends State<TripRecordConfirmation> {
  int? RealTripID;
  Completer<void> _onPressedCompleter = Completer<void>();

  @override
  void initState() {
    super.initState();
  }

  void _onPressed(BuildContext context) async {
    final id = widget.item['id'];
    final String description = 'Trip has started';
    int? Tripid;

    try {
      // Call your apiService to add a trip record
      Tripid = await apiService.addTripRecord(id, description, context);
      print('Inserted Trip ID: $Tripid');

      if (Tripid != null) {
        setState(() {
          RealTripID = Tripid;
        });
        print('RealTripID updated to: $RealTripID');
      } else {
        print('Tripid is null.');
      }
    } catch (e) {
      print('Error: $e');
    }

    _onPressedCompleter.complete(); // Complete the Completer
  }

  TripApiService apiService = TripApiService();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                      width: 64, // Specify width
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: Image.memory(
                            base64Decode(widget.profilePicture!),
                            fit: BoxFit.cover,
                          ).image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  // Adjust the spacing between avatar and text
                  const Text(
                    'Are you sure you need to start this route?',
                  ),
                  // Adjust the spacing between name and email

                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: CustomMaterialButton(
                      label: "Yes",
                      onPressed: () async {
                        if (kDebugMode) {
                          print('mpendwa mteja $RealTripID');
                        }
                        _onPressedCompleter =
                            Completer<void>(); // Reset the Completer
                        _onPressed(context);

                        await _onPressedCompleter
                            .future; // Wait for the Completer to complete

                        Navigator.pop(context);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: FingerPrintAlertDialogButton(
                                  realTripID: RealTripID),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Container(
                  //   margin: EdgeInsets.only(top: 5.0),
                  //   decoration: new BoxDecoration(
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(5.0),
                  //     ),
                  //     boxShadow: <BoxShadow>[
                  //       BoxShadow(
                  //         color: Theme.Colors.loginGradientStart,
                  //         offset: Offset(1.0, 6.0),
                  //         blurRadius: 20.0,
                  //       ),
                  //       BoxShadow(
                  //         color: Theme.Colors.loginGradientEnd,
                  //         offset: Offset(1.0, 6.0),
                  //         blurRadius: 20.0,
                  //       ),
                  //     ],
                  //     gradient: new LinearGradient(
                  //       colors: [
                  //         Theme.Colors.loginGradientEnd,
                  //         Theme.Colors.loginGradientStart
                  //       ],
                  //       begin: const FractionalOffset(0.2, 0.2),
                  //       end: const FractionalOffset(1.0, 1.0),
                  //       stops: [0.0, 1.0],
                  //       tileMode: TileMode.clamp,
                  //     ),
                  //   ),
                  //   child: MaterialButton(
                  //       highlightColor: Colors.transparent,
                  //       splashColor: Theme.Colors.loginGradientEnd,
                  //       //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           vertical: 10.0,
                  //           horizontal: 42.0,
                  //         ),
                  //         child: Text(
                  //           "Next",
                  //           style: TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 25.0,
                  //             fontFamily: "WorkSansBold",
                  //           ),
                  //         ),
                  //       ),
                  //       onPressed: () async {
                  //         print('mpendwa mteja $RealTripID');
                  //         _onPressedCompleter =
                  //             Completer<void>(); // Reset the Completer
                  //         _onPressed(context);
                  //
                  //         await _onPressedCompleter
                  //             .future; // Wait for the Completer to complete
                  //
                  //         showDialog(
                  //           context: context,
                  //           builder: (BuildContext context) {
                  //             return Container(
                  //               child: FingerPrintAlertDialogButton(
                  //                   realTripID: RealTripID),
                  //             );
                  //           },
                  //         );
                  //       }),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
