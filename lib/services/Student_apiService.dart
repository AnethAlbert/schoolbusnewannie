import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newschoolbusapp/models/student.dart';



class StudentApiService {
  ///final String url = "http://192.168.98.168:8080";
  // final String url = "http://192.168.43.26:5900";
  //   final String url = "http://192.168.1.79:8080";
 // final String url = "http://192.168.100.26:8080";
  //final String url = "http://192.168.100.209:8080";
  //final String url = "http://192.168.43.168:8080";
 // final String url = "http://192.168.43.26:8080";
 //  final String url = "http://172.20.10.8:8080";
 // final String url = "http://192.168.100.209:8080";
 //  final String url = "http://192.168.100.219:8080";
  //final String url = "http://192.168.37.55:8080";
  final String url = "http://192.168.135.55:8080";

  final String apiUrl = "/api/v1/StudentProfile";
   final String apiRelation = "/api/v1/psr";
//192.168.100.26

//************************INSERT************************

  Future<Map<String, dynamic>> addFingerPrint(String fingerPrintId) async {
    final String apiUrl = '/api/v1/enroll';

    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'fingerPrintId': fingerPrintId, // Corrected key name
        }),
      );

      if (response.statusCode == 200) {
        // Fingerprint added successfully
        return {'success': true, 'message': 'Fingerprint added successfully'};
      } else {
        throw Exception('Failed to add fingerprint ID: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to add fingerprint ID: $error');
    }
  }


  ///***********************************
  Future<Student> addStudent({
    required String fname,
    required String lname,
    required int classId,
    required int stationId,
    required String registrationNumber,
    required int age,
    required String profilePicture,
    required String digitalFingerprint,
    required BuildContext context,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'fname': fname,
          'lname': lname,
          'class_id': classId,
          'station_id': stationId,
          'registration_number': registrationNumber,
          'age': age,
          'profilepicture': profilePicture,
          'digitalfingerprint': digitalFingerprint,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var token = jsonData['token'];
        var message = jsonData['message'];
        var user = jsonData['user'];

        // Extract the ID from the user object
        int mysqlId = user['id']; // Assuming the ID key is 'id'

        // Create a Student object with the received ID
        Student newStudent = Student(
          id: mysqlId,
          fname: fname,
          lname: lname,
          class_id: classId,
          station_id: stationId,
          registration_number: registrationNumber,
          age: age,
          profilepicture: profilePicture,
          digitalfingerprint: digitalFingerprint,
          // You can set other properties here as needed
        );

        return newStudent;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }



  ///************************************GET**********************************//

  Future<List<Student>> getAllStudents() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Student> students = jsonList.map((json) {
          // Ensure 'lname' and 'age' are not null
          String lname = json['lname'] ?? '';
          int age = json['age'] ?? 0;

          return Student(
            id: json['id'] ?? 0,
            fname: json['fname'] ?? '',
            lname: lname,
            age: age,
            // Add other fields as needed
          );
        }).toList();

        return students;
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }



  ///*******************************GET BY ID ******************************

  Future<Student?> getStudentById(int id) async {
    final String apiUrl = '/api/v1/students/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return Student.fromJson(json);
      } else if (response.statusCode == 404) {
        // Student not found
        print('Student not found');
        return null;
      } else {
        // Handle other status codes, e.g., 500 for internal server error
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }



  // Future<List<Student>?> getParentStudentRelationById(int id) async {
  //   final String apiUrl = '/api/v1/psr/$id';
  //
  //   try {
  //     final response = await http.get(
  //       Uri.parse(url + apiUrl),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Successful response
  //       final dynamic jsonData = jsonDecode(response.body);
  //       if (jsonData is List<dynamic>) {
  //         // List of student objects received
  //         return jsonData.map((studentJson) => Student.fromJson(studentJson)).toList();
  //       } else if (jsonData is Map<String, dynamic>) {
  //         // Single student object received, return as a list
  //         return [Student.fromJson(jsonData)];
  //       } else {
  //         // Empty response or unexpected format
  //         print('Empty response or unexpected format');
  //         return null;
  //       }
  //     } else if (response.statusCode == 404) {
  //       // Relation not found
  //       print('Relation not found');
  //       return null;
  //     } else {
  //       // Handle other status codes, e.g., 500 for internal server error
  //       print('Error: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     // Print any error that occurred
  //     print('Error: $error');
  //     return null;
  //   }
  // }

  Stream<List<Student>?> parentStudentRelationStream(int id) async* {
    final String apiUrl = '/api/v1/psr/$id';
    final controller = StreamController<List<Student>?>();

    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final dynamic jsonData = jsonDecode(response.body);
        if (jsonData is List<dynamic>) {
          controller.add(jsonData.map((studentJson) => Student.fromJson(studentJson)).toList());
        } else if (jsonData is Map<String, dynamic>) {
          controller.add([Student.fromJson(jsonData)]);
        } else {
          controller.addError('Empty response or unexpected format');
        }
      } else if (response.statusCode == 404) {
        controller.addError('Relation not found');
      } else {
        controller.addError('Error: ${response.statusCode}');
      }
    } catch (error) {
      controller.addError('Error: $error');
    }

    yield* controller.stream;
    controller.close();
  }

  ///************************************DELETE********************************
  Future<void> removeStudentById(int id) async {
    final String apiUrl = '/api/v1/students/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Student deleted successfully');
      } else if (response.statusCode == 404) {
        print('Student not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //*********************************UPDATE********************************

  Future<void> updateStudentById(int id, String fname) async {
    final String apiUrl = '/api/v1/students/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': fname}),
      );

      if (response.statusCode == 200) {
        print('Student updated successfully');
      } else if (response.statusCode == 404) {
        print('Student not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


}













