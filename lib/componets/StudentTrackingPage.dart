import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newschoolbusapp/secrets.dart';

class studentTrackingPage extends StatefulWidget {
  const studentTrackingPage({Key? key}) : super(key: key);

  @override
  State<studentTrackingPage> createState() => _studentTrackingPageState();
}

class _studentTrackingPageState extends State<studentTrackingPage> {
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

    if (result != null && result.points != null && result.points.isNotEmpty) {
      setState(() {
        polylineCoordinates = result.points
            .map((point) => LatLng(point.latitude, point.longitude))
            .toList();
      });
    } else {
      print("No polyline points found");
      // Handle the case where no polyline points are available
    }
  }


  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     Secrets.API_KEY,
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
  //   );
  //
  //   if (!result.points.isEmpty) {
  //     setState(() {
  //       polylineCoordinates = result.points
  //           .map((point) => LatLng(point.latitude, point.longitude))
  //           .toList();
  //     });
  //   }
  // }

  // void getPolyPoints() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     Secrets.API_KEY,
  //     PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
  //     PointLatLng(destinationLocation.latitude, destinationLocation.longitude),
  //   );
  //
  //   if (result.points != null && result.points.isNotEmpty) {
  //     setState(() {
  //       polylineCoordinates = result.points
  //           .map((point) => LatLng(point.latitude, point.longitude))
  //           .toList();
  //     });
  //   } else {
  //     print("No polyline points found");
  //     // Handle the case where no polyline points are available
  //   }
  // }


  @override
  void initState(){
    getPolyPoints();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("student Tracking"),
        titleTextStyle: TextStyle(color: Colors.black, fontSize: 16),
      ),
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: sourceLocation, zoom: 14.5),

        polylines: {
          Polyline(
            polylineId: PolylineId("route"),
            points: polylineCoordinates,
          )
        },
        markers: {
          Marker(
            markerId: MarkerId("source"),
            position: sourceLocation,
          ),
          Marker(
            markerId: MarkerId("destination"),
            position: destinationLocation,
          ),
        },
      ),
    );
  }
}
