import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/ui/live/mapPage.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';

// import 'package:schoolbassapp/ui/registration/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/ui/registration/gurdianRegistation.dart';
import 'package:newschoolbusapp/ui/registration/parentRegistration.dart';
import 'package:newschoolbusapp/ui/registration/studentRegistration.dart';
import 'package:newschoolbusapp/ui/registration/tripRegistry.dart';
import 'package:newschoolbusapp/widgets/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/widgets/bottomNavigationClass.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/controllers/trip_controller.dart';
import '../../core/services/Gurdian_apiService.dart';
import '../../core/services/fingerPrint_ApiService.dart';
import '../../widgets/custom_card_button.dart';
import '../trip_pages/trip_page.dart';

class RegistrationRoom extends StatefulWidget {
  const RegistrationRoom({super.key});

  @override
  State<RegistrationRoom> createState() => _RegistrationRoomState();
}

class _RegistrationRoomState extends State<RegistrationRoom> {
  final Color customRed = Color(0xFF26B170);
  final Color customColor = Color(0xFF5b040d);
  final Color customBlue = Color(0xFF104486);
  final Color customParent = Color(0xFF293241);
  final Color tripParameters = Color(0xFFdd6e42);

  late TripController tripController;
  final FingerPrintApiService _apiService = FingerPrintApiService();

  @override
  void initState() {
    super.initState();
    tripController = TripController();
  }

  @override
  Widget build(BuildContext context) {
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 50.0, right: 50.0, bottom: 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 30,
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text("Registration Room"),
                          ),
                        ),
                      ),
                    )),

                ///*****************************guildan,parent,student****************
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //   Padding(padding: const EdgeInsets.all(8.0)),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ParentRegistrationClass()),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: customParent,
                                        width: 80,
                                        height: 100,
                                        child: const Center(
                                          child: Text(
                                            "Parents",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const StudentRegistrationClass()),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: customBlue,
                                        width: 80,
                                        height: 100,
                                        child: const Center(
                                          child: Text(
                                            "Student",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const GuardianRegistrationClass()),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: customColor,
                                        width: 80,
                                        height: 100,
                                        child: const Center(
                                          child: Text(
                                            "Guardian",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //   Padding(padding: const EdgeInsets.all(8.0)),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const TripRegistry(),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: customParent,
                                        width: 80,
                                        height: 100,
                                        child: const Center(
                                          child: Text(
                                            "Trip Registry",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                //ProfilePictureWidget())
                                                const autocomplete()),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        color: customBlue,
                                        width: 80,
                                        height: 100,
                                        child: const Center(
                                          child: Text(
                                            "S&P Relation",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 15),
                    child: Text(
                      "Trip Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomCardButton(
                          label: "Start Trip",
                          showBorder: false,
                          onTap: () async {
                            loadingDialog(context);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            int? activeTripId = prefs.getInt('pref_id');
                            int tripId = await tripController
                                .fetchLastActiveTripId(activeTripId ?? 0);
                            if (mounted) {
                              Navigator.pop(context);
                              if (tripId == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const StartTripPage(),
                                  ),
                                );
                              } else {
                                customSnackBar(
                                    context,
                                    "You have an active trip. Consider finishing the active trip before starting a new one.",
                                    null);
                              }
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: CustomCardButton(
                          label: "Continue Trip",
                          showBorder: true,
                          onTap: () async {
                            loadingDialog(context);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            int? guardianId = prefs.getInt('pref_id');

                            int tripId = await tripController
                                .fetchLastActiveTripId(guardianId ?? 0);

                            if (!mounted) {
                              return;
                            }

                            Navigator.pop(context);

                            if (tripId == 0) {
                              customSnackBar(
                                  context,
                                  "You have no active trip. Start a new trip to continue.",
                                  null);
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                _apiService
                                    .getFingerprintID()
                                    .then((response) async {
                                  if (response != null) {
                                    // ---------********************
                                    // ---------********************

                                    int fingerprintGuardianId =
                                        int.parse(response);

                                    loadingDialog(context);

                                    if (mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      customSnackBar(
                                          context, "Success", Colors.green);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TripPage(realTripID: tripId),
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

                            // ***************************
                            // ***************************
                            // ***************************
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
