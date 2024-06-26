import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/fireBaseModels/pSrfb.dart';
import '../utils/constants.dart';

class ParentStudentRelationApiService {
  final String apiUrl = "/api/v1/psr";

//************************INSERT************************
  Future<ParentStudentRelation> addParentStudentRelation(
      int parent_id, int student_id, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'parent_id': parent_id,
          'student_id': student_id,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        // You need to return a Parent here
        return ParentStudentRelation(
            /* initialize Parent object with required data */);
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

  ///*********************************GET****************************//
  Future<List<ParentStudentRelation>> getAllParentStudentRelations() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList
            .map((json) => ParentStudentRelation.fromJson(json))
            .toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

//******************************GET BY ID*******************//
  Future<ParentStudentRelation?> getParentStudentRelationById(int id) async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return ParentStudentRelation.fromJson(json);
      } else if (response.statusCode == 404) {
        // Relation not found
        print('Relation not found');
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

//************************************DELETE*******************************//

  Future<bool> removeParentStudentRelationById(
      int parentId, int studentId) async {
    final String apiUrl = '/api/v1/psr/$parentId/$studentId';
    bool result = false;

    try {
      final response = await http.delete(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      print("RESPONSE: ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        result = data["success"];
      } else if (response.statusCode == 404) {
      } else {
        throw Exception('Unexpected error occurred');
      }
      return result;
    } catch (error) {
      if (kDebugMode) {
        print('Error: $error');
      }
      return result;
    }
  }

//********************************UPDATE*********************************//
  Future<void> updateParentStudentRelationById(int id, int student_id) async {
    final String apiUrl = '/api/v1/psr/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'student_id': student_id}),
      );

      if (response.statusCode == 200) {
        print('Parent-Student Relation updated successfully');
      } else if (response.statusCode == 404) {
        print('Parent-Student Relation not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
