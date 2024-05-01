import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class spRelation extends StatefulWidget {
  const spRelation({Key? key}) : super(key: key);

  @override
  State<spRelation> createState() => _spRelationState();
}

class _spRelationState extends State<spRelation> {

  final Color customRed = Color(0xFF26B170);
  final Color customColor = Color(0xFF5b040d);
  final Color customBlue = Color(0xFF104486);
  final Color customParent = Color(0xFF293241);
  final Color tripParameters = Color(0xFFdd6e42);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Container(
                            // color: Colors.blue,
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                        'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
                                  ),
                                  SizedBox(width: 16.0),
                                  // Adjust the spacing between the avatar and the username
                                  Text(
                                    'Keifo Primary School',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                        Flexible(
                          flex: 2,
                          child: Container(
                            //color: Colors.grey,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Ionicons.ios_search,),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(Ionicons.ios_alert,),
                                )
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
                    top: 0.0, left: 50.0, right: 50.0, bottom: 0.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: 30,
                    child: Container(
                      color: Colors.white,
                      child: Center(child: Text("S&P Relation")),
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

                              Container(
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

                              Container(
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

                              Container(
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

                              Container(
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contact',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}


