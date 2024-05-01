import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:newschoolbusapp/models/TripRecordClass.dart';
import 'package:newschoolbusapp/models/route.dart';
import 'package:newschoolbusapp/services/Route_apiService.dart';
import 'package:newschoolbusapp/services/Trip_apiService.dart';
import 'package:newschoolbusapp/ui/bucket01/bucket01Class.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/FIngerPrintDialogBox.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      content: Container(
        width: 300,
        height: 200,
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
                    SizedBox(height: 2),
                    // Adjust the spacing between avatar and text
                    Text(
                      'Are you sure you need to start this route ?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // Adjust the spacing between name and email

                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5.0),
                        ),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Theme.Colors.loginGradientStart,
                            offset: Offset(0.0, 3.0), // Adjusted offset
                            blurRadius: 10.0, // Adjusted blurRadius
                          ),
                          BoxShadow(
                            color: Theme.Colors.loginGradientEnd,
                            offset: Offset(0.0, 3.0), // Adjusted offset
                            blurRadius: 10.0, // Adjusted blurRadius
                          ),
                        ],
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
                        highlightColor: Colors.transparent,
                        splashColor: Theme.Colors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0, // Adjusted vertical padding
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
                        onPressed: () async {
                          print('mpendwa mteja $RealTripID');
                          _onPressedCompleter =
                              Completer<void>(); // Reset the Completer
                          _onPressed(context);

                          await _onPressedCompleter
                              .future; // Wait for the Completer to complete

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
            ),
          ],
        ),
      ),
    );
  }
}

