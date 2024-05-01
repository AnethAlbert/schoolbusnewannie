import 'dart:async';

import 'package:flutter/material.dart';
import 'package:newschoolbusapp/componets/constants.dart';
import 'package:newschoolbusapp/secrets.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newschoolbusapp/ui/Report/WeekReport.dart';
import 'package:newschoolbusapp/ui/Report/mouthReport.dart';

class BucketMap03 extends StatefulWidget {
  const BucketMap03({Key? key}) : super(key: key);

  @override
  State<BucketMap03> createState() => _BucketMap03State();
}

class _BucketMap03State extends State<BucketMap03> {
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  static const sourceLocation = LatLng(-6.77363, 39.22093);
  static const destinationLocation = LatLng(-6.78615, 39.22608);

  List<LatLng> polylineCoordinates = [];

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.API_KEY,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
    );

    if (!result.points.isEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    }
  }

  @override
  void initState() {
    getPolyPoints();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              //https://images.unsplash.com/photo-1582909184893-1492bc753037?q=80&w=1911&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1584972191378-d70853fc47fc?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
                // child: YourWidget(),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: double.infinity,
                  height: 50.0,
                  color: Colors.white,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          // Handle back button press
                        },
                      ),

                      SizedBox(width: 8.0),
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            'https://media.istockphoto.com/id/1353379172/photo/cute-little-african-american-girl-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=KI0p6tdb1rV8Uj-A9095dhtlD6RYSQcILmbCJgfPMMU='),
                      ),
                      SizedBox(width: 8.0), // Add spacing between widgets
                      Text('Enock Damas'),
                      SizedBox(width: 250.0), // Add spacing between widgets
                      Expanded(
                        flex: 7,
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 5,
                              backgroundColor: Colors.green,
                              // Add circular avatar properties
                            ),
                            SizedBox(width: 4.0), // Add spacing between widgets
                            Text('In Bus'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    // Adjust padding as needed
                    child: Container(
                      width: 350,
                      height: 400,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 340,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors
                                        .blue, // Adjust the color as needed
                                  ),
                                  SizedBox(width: 8.0),
                                  Center(
                                    child: Text(
                                      '10:00 am',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Pickup',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Text(
                                            'Kituo cha Mbuyuni',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),


                            Padding(
                              padding: EdgeInsets.only(left: 25.0,top: 3.0),
                              child: Container(
                                width: 2, // Adjust the width of the line
                                height: 40,
                                child: CustomPaint(
                                  painter: VerticalDottedLinePainter(),
                                ),
                              ),
                            ),
                          //  SizedBox(height: 20.0),

                            Container(
                              width: 340,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.timer,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors
                                        .blue, // Adjust the color as needed
                                  ),
                                  SizedBox(width: 8.0),
                                  Center(
                                    child: Text(
                                      '10:30 am',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Remainder',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Text(
                                            'Kituo cha Mzambar',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 25.0,top: 3.0),
                              child: Container(
                                width: 2, // Adjust the width of the line
                                height: 40,
                                child: CustomPaint(
                                  painter: VerticalDottedLinePainter(),
                                ),
                              ),
                            ),

                            Container(
                              width: 340,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.school,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors
                                        .grey, // Adjust the color as needed
                                  ),
                                  SizedBox(width: 8.0),
                                  Center(
                                    child: Text(
                                      '11:00 am',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'At School',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Text(
                                            'Kituo cha Mzambarauni',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 25.0,top: 3.0),
                              child: Container(
                                width: 2, // Adjust the width of the line
                                height: 40,
                                child: CustomPaint(
                                  painter: VerticalDottedLinePainter(),
                                ),
                              ),
                            ),

                            Container(
                              width: 340,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.timer,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors
                                        .grey, // Adjust the color as needed
                                  ),
                                  SizedBox(width: 8.0),
                                  Center(
                                    child: Text(
                                      '05:00 pm',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Remainder',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Kituo cha Mzambar',
                                              style: TextStyle(fontSize: 14.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            Padding(
                              padding: EdgeInsets.only(left: 25.0,top: 3.0),
                              child: Container(
                                width: 2, // Adjust the width of the line
                                height: 40,
                                child: CustomPaint(
                                  painter: VerticalDottedLinePainter(),
                                ),
                              ),
                            ),

                            Container(
                              width: 340,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    child: Icon(
                                      Icons.location_on,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors
                                        .grey, // Adjust the color as needed
                                  ),
                                  SizedBox(width: 8.0),
                                  Center(
                                    child: Text(
                                      '06:00 pm',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Drop',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                          Text(
                                            'Kituo cha Mbuyuni',
                                            style: TextStyle(fontSize: 14.0),
                                          ),
                                        ],
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
              )
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
          onTap: (int index) {
            // Handle navigation when an item is tapped
            if (index == 3) {
              // Assuming the 'Contact' item is at index 3
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => weekklyAttendacyClass()),
              );
            }else if (index ==2){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mouthReportClass()),
              );
            }
          },
        ),
      ),
    );
  }
}
