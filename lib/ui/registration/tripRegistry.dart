import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/gurdian/registrationRoom.dart';
import 'package:newschoolbusapp/ui/live/mapPage.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';
import 'package:newschoolbusapp/ui/registration/BusRegistration.dart';
import 'package:newschoolbusapp/ui/registration/ClassesRegistration.dart';
import 'package:newschoolbusapp/ui/registration/RouteRegistration.dart';
import 'package:newschoolbusapp/ui/registration/StationRegistration.dart';
import 'package:newschoolbusapp/ui/registration/gurdianRegistation.dart';
import 'package:newschoolbusapp/ui/registration/parentRegistration.dart';
import 'package:newschoolbusapp/ui/registration/studentRegistration.dart';
import 'package:newschoolbusapp/widgets/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/widgets/bottomNavigationClass.dart';

class Trip_Registry extends StatefulWidget {
  const Trip_Registry({Key? key}) : super(key: key);

  @override
  State<Trip_Registry> createState() => _Trip_RegistryState();
}

class _Trip_RegistryState extends State<Trip_Registry> {
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

  final Color customRed = Color(0xFF26B170);
  final Color customColor = Color(0xFF5b040d);
  final Color customBlue = Color(0xFF104486);
  final Color customParent = Color(0xFF293241);
  final Color tripParameters = Color(0xFFdd6e42);

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              Padding(
                  padding: const EdgeInsets.only(
                      top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 30,
                      child: Container(
                        color: Colors.white,
                        child: Center(child: Text("Trip Registry")),
                      ),
                    ),
                  )),
      
              ///*****************************parent,student****************
      
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              BussRegistration()),
                                    );
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Bus",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        color: tripParameters,
                                        width: 300,
                                        height: 50,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
      ///////******************************register CLass***************************************
      
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              StationRegistration()),
                                    );
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Station",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        color: tripParameters,
                                        width: 300,
                                        height: 50,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              RouteRegistration()),
                                    );
                                  },
                                  child: Container(
                                    //RouteRegistration
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Route",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        color: tripParameters,
                                        width: 300,
                                        height: 50,
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                              ClassRegistration()),
                                    );
                                  },
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "Class",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        color: tripParameters,
                                        width: 300,
                                        height: 50,
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
            ],
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
