import 'dart:convert';
import 'dart:typed_data';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:newschoolbusapp/models/gurdian.dart';
import 'package:newschoolbusapp/models/route.dart';
import 'package:newschoolbusapp/services/Gurdian_apiService.dart';
import 'package:newschoolbusapp/services/Route_apiService.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/bucket01/bucket01Class.dart';
import 'package:newschoolbusapp/ui/bucket02/bucket02Class.dart';
import 'package:get/get.dart';
import 'package:newschoolbusapp/ui/gurdian/registrationRoom.dart';
import 'package:newschoolbusapp/ui/live/mapPage.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';
import 'package:newschoolbusapp/widgets/FIngerPrintDialogBox.dart';
import 'package:newschoolbusapp/widgets/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/widgets/bottomNavigationClass.dart';
import 'package:newschoolbusapp/widgets/profilePictDialogBox.dart';
import 'package:newschoolbusapp/widgets/routeList.dart';
import 'package:newschoolbusapp/widgets/tripRecordTableConfimation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class noSummaryClass extends StatefulWidget {
  const noSummaryClass({Key? key}) : super(key: key);

  @override
  State<noSummaryClass> createState() => _noSummaryClassState();
}

class _noSummaryClassState extends State<noSummaryClass> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to MyProfileGurdian when Profile tab is clicked (index 3)
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => registrationRoom()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => autocomplete()),
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyProfileGurdian()),
      );
    }
  }

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
      return Center(
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

  TableRow _tableRow = const TableRow(children: [
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
          child: SingleChildScrollView(
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
                      height: 100,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [

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
                Padding(
                    padding: const EdgeInsets.only(
                         left: 50.0, right: 50.0,),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: 30,
                        child: Container(
                          color: Colors.white,
                          child: Center(child: Text("No Summary Found")),
                        ),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.only(
                         left: 50.0, right: 50.0, ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        //   color: Colors.white,
                        width: double.infinity,
                        //  height: 200,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Crystal128-folder-red.svg/640px-Crystal128-folder-red.svg.png',
                              width: 250.0,
                              height: 230.0,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                    )),
                Container(
                  margin: EdgeInsets.only(top: 10.0,bottom: 10),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientStart
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: MaterialButton(
                      highlightColor: Colors.transparent,
                      splashColor: Theme.Colors.loginGradientEnd,
                      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 42.0),
                        child: Text(
                          "Record Attendacy",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontFamily: "WorkSansBold"),
                        ),
                      ),
                      onPressed: () {
                        print(routes);
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
                                                itemCount: routes.length,
                                                itemBuilder: (context, index) {
                                                  final item = routes[index];
                                                  return Padding(
                                                    padding: const EdgeInsets.only(
                                                      left: 20.0,
                                                      right: 20.0,
                                                      top: 5,
                                                    ),
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: 30.0),
                                                      decoration: new BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    5.0)),
                                                        boxShadow: <BoxShadow>[
                                                          BoxShadow(
                                                            color: Theme.Colors
                                                                .loginGradientStart,
                                                            offset:
                                                                Offset(1.0, 6.0),
                                                            blurRadius: 20.0,
                                                          ),
                                                          BoxShadow(
                                                            color: Theme.Colors
                                                                .loginGradientEnd,
                                                            offset:
                                                                Offset(1.0, 6.0),
                                                            blurRadius: 20.0,
                                                          ),
                                                        ],
                                                        gradient:
                                                            new LinearGradient(
                                                          colors: [
                                                            Theme.Colors
                                                                .loginGradientEnd,
                                                            Theme.Colors
                                                                .loginGradientStart
                                                          ],
                                                          begin:
                                                              const FractionalOffset(
                                                                  0.2, 0.2),
                                                          end:
                                                              const FractionalOffset(
                                                                  1.0, 1.0),
                                                          stops: [0.0, 1.0],
                                                          tileMode: TileMode.clamp,
                                                        ),
                                                      ),
                                                      child: MaterialButton(
                                                        highlightColor:
                                                            Colors.transparent,
                                                        splashColor: Theme.Colors
                                                            .loginGradientEnd,
                                                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                                        child: Padding(
                                                          padding: const EdgeInsets
                                                              .symmetric(
                                                            vertical: 10.0,
                                                            horizontal: 42.0,
                                                          ),
                                                          child: Text(
                                                            item['name'],
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25.0,
                                                              fontFamily:
                                                                  "WorkSansBold",
                                                            ),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          print("routeId = $item");
                                                          showDialog(
                                                            context: context,
                                                            builder: (BuildContext
                                                                context) {
                                                              return Container(
                                                                  child: TripRecordConfirmation(
                                                                      item,
                                                                      profilePicture:
                                                                          _profilepicture)
                                                                  //FingerPrintAlertDialogButton(),
                                                                  //ProfilePicDialogBox()
                                                                  );
                                                            },
                                                          );
                                                        },
                                                      ),
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
                      }
                      //     Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => Buck01Class()),
                      // ),
                      ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
