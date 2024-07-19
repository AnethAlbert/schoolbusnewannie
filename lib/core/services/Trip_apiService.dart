import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newschoolbusapp/core/models/student_attendance_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/TripRecordClass.dart';
import '../models/route.dart';
import '../utils/constants.dart';

class TripApiService {
  final String apiUrl = "/api/v1/trip_record";

//192.168.100.26

//************************INSERT************************
//
//   Future<TripRecord> addTripRecord(
//       int routeId,
//       String description,
//       BuildContext context,
//       ) async {
//    // final String apiUrl = 'your_api_url_here'; // Replace with your API endpoint
//
//     try {
//       var response = await http.post(
//         Uri.parse(url + apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'routeid': routeId,
//           'description':description
//         }),
//       );
//
//       if (response.statusCode == 201) {
//         var jsonData = jsonDecode(response.body);
//         // Assuming your response contains the newly created trip record data
//         var id = jsonData['id'];
//         print("trip RecordID ya ukweli kabisa= $id");
//
//         return TripRecord();
//       } else {
//         var jsonData = jsonDecode(response.body);
//         String errorMessage = jsonData['error'];
//         if (errorMessage == null || errorMessage.isEmpty) {
//           errorMessage = 'An error occurred';
//         }
//         throw Exception(errorMessage);
//       }
//     } catch (e) {
//       print(e);
//       throw Exception('Error while connecting to API');
//     }
//   }

  //****************************student_trip_list****************************************************

  Future<Map<String, dynamic>> addStudentTripList(
      int tripId, int studentId) async {
    final String apiUrl = '/api/v1/studenttriplist';

    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
            <String, dynamic>{'trip_id': tripId, 'student_id': studentId}),
      );

      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Fingerprint added successfully
        return {'success': true, 'message': data["message"]};
      } else {
        throw Exception(data["message"]);
      }
    } catch (error) {
      throw Exception(' $error');
    }
  }

  Future<List<String>?> getStudentIDRecordByTripId(int id) async {
    final String apiUrl =
        '/api/v1/studenttriplist/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      // Handle response based on status code
      switch (response.statusCode) {
        case 200:
          // Successful response, parse the JSON array
          List<dynamic> jsonResponse = jsonDecode(response.body);
          List<String> studentIds =
              jsonResponse.map((id) => id.toString()).toList();
          print(studentIds);
          return studentIds;
        case 404:
          // Trip record not found
          print('Trip record not found');
          return null;
        default:
          // Handle other status codes
          final responseBody = jsonDecode(response.body);
          final errorMessage =
              responseBody['message'] ?? 'Failed to fetch data';
          print('Error: ${response.statusCode}, Message: $errorMessage');
          return null;
      }
    } catch (error) {
      // Handle network or parsing errors
      print('Error: $error');
      return null;
    }
  }

  //***********************************************************************************************************************************************

  Future<RouteClass> getRouteIDFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return RouteClass(
      id: prefs.getInt('prefTripID'),
    );
  }

  Future<int> fetchLastActiveTripId(int guardianId) async {
    final String apiUrl = '/api/v1/trip_record/active/$guardianId';
    int tripId = 0;
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        tripId = int.parse(data[0]["id"].toString());
      }
      return tripId;
    } catch (e) {
      return tripId;
    }
  }

  Future<bool> endTrip(int tripId) async {
    bool result = false;
    final String apiUrl = '/api/v1/trip_record/end/$tripId';
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        result = data["success"];
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<bool> dropStudent(int tripId, int studentId) async {
    bool result = false;
    const String apiUrl = '/api/v1/trip_record/drop-student';

    Map<String, dynamic> body = {
      "studentId": studentId,
      "tripId": tripId,
    };

    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        result = data["success"];
      }
      return result;
    } catch (e) {
      return result;
    }
  }

  Future<int> addTripRecord(
      int routeId, String description, BuildContext context) async {
    final String apiUrl = '/api/v1/trip_record'; // Your API endpoint

    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'routeid': routeId,
          'description': description,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var insertedId = jsonData[
            'id']; // Assuming your response contains the ID of the newly inserted record
        return insertedId;
      } else {
        throw Exception('Failed to add trip record');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error adding trip record');
    }
  }

  ///*********************************GET****************************//
  Future<List<TripRecord>> getAllTripRecords() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => TripRecord.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

  Future<List<StudentAttendanceModel>> getStudentsAttendance(int tripId) async {
    final String apiUrl = "/api/v1/trip_record/students-attendance/$tripId";
    List<StudentAttendanceModel> attendanceList = [];
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        attendanceList = (data['data'] as List)
            .map((json) => StudentAttendanceModel.fromJson(json))
            .toList();
        return attendanceList;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      return attendanceList;
    }
  }

//******************************GET  BY ID*******************//
  Future<List<TripRecord>?> getTripRecordById(int id) async {
    final String apiUrl =
        '/api/v1/trip_record/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        List<TripRecord> tripRecords =
            jsonList.map((json) => TripRecord.fromJson(json)).toList();
        return tripRecords;
      } else if (response.statusCode == 404) {
        // Trip record not found
        print('Trip record not found');
        return null;
      } else {
        // Handle other status codes, e.g., 500 for internal server error
        print('Error: ${response.statusCode}');
        return null; // You might want to throw an exception or handle errors differently
      }
    } catch (error) {
      print('Error: $error');
      return null; // You might want to throw an exception or handle errors differently
    }
  }

//************************************DELETE*******************************//
  Future<void> removeTripRecordById(int id) async {
    final String apiUrl =
        '/api/v1/trip_record/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Trip record deleted successfully');
      } else if (response.statusCode == 404) {
        print('Trip record not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

//********************************UPDATE*********************************//
  Future<void> updateTripRecordById(int Tripid, int gurdianid, context) async {
    final String apiUrlUpdate =
        '/api/v1/trip_record/$Tripid'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(url + apiUrlUpdate),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'gurdianid': gurdianid}),
      );

      if (response.statusCode == 200) {
        print('Trip Record updated successfully');
      } else if (response.statusCode == 404) {
        print('Trip Record not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //********************************DOOR*********************************//
  Future<void> openCloseDoor(String command) async {
    const String apiUrl = '/api/v1/servo-motor/send-command';
    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'command': command}),
      );

      print('RESPONSE: ${response.body}');
      print('CODE: ${response.statusCode}');

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Door command successfully');
        }
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
    }
  }
}
