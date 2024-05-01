import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/testing/profilepic.dart';
import 'package:newschoolbusapp/ui/bucket/bucketnew.dart';
import 'package:newschoolbusapp/ui/live/mapPage.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';
import 'package:newschoolbusapp/ui/registration/Parent&StudentRelation.dart';
// import 'package:schoolbassapp/ui/registration/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/ui/registration/gurdianRegistation.dart';
import 'package:newschoolbusapp/ui/registration/parentRegistration.dart';
import 'package:newschoolbusapp/ui/registration/studentRegistration.dart';
import 'package:newschoolbusapp/ui/registration/tripRegistry.dart';
import 'package:newschoolbusapp/widgets/ParentSeachAutocomplete.dart';
import 'package:newschoolbusapp/widgets/bottomNavigationClass.dart';

class registrationRoom extends StatefulWidget {
  const registrationRoom({Key? key}) : super(key: key);

  @override
  State<registrationRoom> createState() => _registrationRoomState();
}

class _registrationRoomState extends State<registrationRoom> {

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
        MaterialPageRoute(builder: (context) =>
            MyProfileGurdian()

        ),
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
                          child: Center(child: Text("Registration Room")),
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
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                               //   Padding(padding: const EdgeInsets.all(8.0)),
            
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ParentRegistrationClass()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text(
                                              "Parents",
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                          color: customParent,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
            
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => StudentRegistrationClass()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text("Student",
                                            style: TextStyle(
                                              color: Colors.white
                                            ),),
                                          ),
                                          color: customBlue,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
            
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => GurdianRegistrationClass()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text("Gurdian",
                                            style: TextStyle(
                                              color: Colors.white
                                            ),),
                                          ),
                                          color: customColor,
                                          width:100,
                                          height: 100,
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
                                        MaterialPageRoute(builder: (context) => Trip_Registry()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text("Trip Registry",
                                              style: TextStyle(
                                                  color:Colors.white
                                              ),),
                                          ),
                                          color: customParent,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                    ),
                                  ),
            
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to the parent registration screen here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                      //ProfilePictureWidget())
                                            autocomplete()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text("S&P Realation",
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
                                          ),
                                          color: customBlue,
                                          width: 100,
                                          height: 100,
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
            
            
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //   Padding(padding: const EdgeInsets.all(8.0)),
            
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => noSummaryClass()),
                                      );
                                    },
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          child: Center(
                                            child: Text("Start Trip",
                                              style: TextStyle(
                                                  color: Colors.white
                                              ),),
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
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}


