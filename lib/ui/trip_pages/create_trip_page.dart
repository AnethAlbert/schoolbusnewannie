import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/tripRecordTableConfimation.dart';

import '../../core/models/gurdian.dart';
import '../../core/models/route.dart';
import '../../core/services/Gurdian_apiService.dart';
import '../../core/services/Route_apiService.dart';

class StartTripPage extends StatefulWidget {
  const StartTripPage({Key? key}) : super(key: key);

  @override
  State<StartTripPage> createState() => _StartTripPageState();
}

class _StartTripPageState extends State<StartTripPage> {
  List<Map<String, dynamic>> routes = [];
  String? selectedroutes;

  @override
  void initState() {
    super.initState();
    _fetchGurdianDetails();
    fetchRoutes();
  }

  int? id;
  String? _fname;
  String? _lname;
  String? _phone;
  String? _email;
  String? _profilepicture;
  String? _digitalfingerprint;

  Future<void> fetchRoutes() async {
    try {
      List<RouteClass> fetchedRoutes = await RouteApiService().getAllRoutes();
      setState(() {
        routes = fetchedRoutes.map((routes) {
          return {
            'id': routes.id,
            'code': routes.code,
            'name': routes.name,
          };
        }).toList();

        print(routes);
        selectedroutes = routes.isNotEmpty ? routes.first['name'] : null;
      });
    } catch (e) {
      // Handle error, such as displaying an error message
      print('Error fetching routes: $e');
    }
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

  //AudioPlayer audioPlayer = AudioPlayer();

  Future<Widget> showImage() async {
    if (_profilepicture != null && _profilepicture!.isNotEmpty) {
      // Load profile picture asynchronously
      Uint8List imageData = await fetchImage(_profilepicture!);
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(imageData),
      );
    } else {
      return const Center(
        child: Text('No image selected'),
      );
    }
  }

  Future<Uint8List> fetchImage(String profilepicture) async {
    Uint8List imageData = base64Decode(profilepicture);
    return imageData;
  }

  @override
  void dispose() {
    //audioPlayer.dispose();
    super.dispose();
  }

  // Future<void> _playSound() async {
  //   int result = await audioPlayer.play(
  //     'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  //     isLocal: false,
  //   );
  //
  //   if (result == 1) {
  //     print('Sound played successfully');
  //   } else {
  //     print('Error playing sound');
  //   }
  // }

  final TableRow _tableRow = const TableRow(children: [
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("no"),
    ),
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("Name"),
    ),
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("Absent"),
    ),
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("Dism"),
    ),
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("Present"),
    ),
    Padding(
      padding: EdgeInsets.all(2.0),
      child: Text("%"),
    )
  ]);

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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 20,
                          offset: const Offset(1, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    formattedTime,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    formattedDate,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Welcome $_fname" ?? 'Loading...',
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 30,
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text("No Summary Found"),
                          ),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                      left: 50.0,
                      right: 50.0,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        //   color: Colors.white,
                        width: double.infinity,
                        //  height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Image.network(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Crystal128-folder-red.svg/640px-Crystal128-folder-red.svg.png',
                            width: 250.0,
                            height: 230.0,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomMaterialButton(
                    label: "Record Attendance",
                    onPressed: () {
                      if (kDebugMode) {
                        print(routes);
                      }
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                  height: 700,
                                  width: double.infinity,
                                  color: Colors.white,
                                  child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        ////*******************Button********************
                                        children: [
                                          SizedBox(
                                            height: 600,
                                            child: ListView.builder(
                                              padding: const EdgeInsets.only(
                                                  top: 20),
                                              itemCount: routes.length,
                                              itemBuilder: (context, index) {
                                                final item = routes[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0,
                                                  ),
                                                  child: CustomMaterialButton(
                                                    label: item['name'],
                                                    onPressed: () {
                                                      if (kDebugMode) {
                                                        print(
                                                            "routeId = $item");
                                                      }
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return TripRecordConfirmation(
                                                            item,
                                                            profilePicture:
                                                                _profilepicture,
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ]
                                        // RouteList(routes: routes.map((route) => RouteClass.fromJson(route)).toList()),

                                        //  ],
                                        ////*******************Button********************
                                        ),
                                  )),
                            );
                          });
                    },
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
