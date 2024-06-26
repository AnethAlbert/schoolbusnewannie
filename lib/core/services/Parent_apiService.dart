import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/parent.dart';
import '../utils/constants.dart';

class ParentApiService {
  final String apiUrl = "/api/v1/parentProfile";

//192.168.100.26

//************************INSERT************************

  Future<Parent> addParent({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String profilePicture,
    required String password,
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
          'email': email,
          'phone': phone,
          'profilepicture': profilePicture,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var token = jsonData['token'];
        var message = jsonData['message'];
        var user = jsonData['user'];

        // Extract the ID from the user object
        int mysqlId = user['id']; // Assuming the ID key is 'id'

        // Create a Gurdian object with the received ID
        Parent newParent = Parent(
          id: mysqlId,
          fname: fname,
          lname: lname,
          email: email,
          phone: phone,
          profilepicture: profilePicture,
          password: password,
          // You can set other properties here as needed
        );

        return newParent;
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

  Future<List<Parent>> getAllParents() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Parent.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

  //******************************GET PARENT BY ID*******************//

  Future<Parent?> getParentById(int id) async {
    final String apiUrl =
        '/api/v1/parentProfile/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return Parent.fromJson(json);
      } else if (response.statusCode == 404) {
        // Parent not found
        print('Parent not found');
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

  Future<void> removeParentById(int id) async {
    final String apiUrl =
        '/api/v1/parentProfile/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Parent deleted successfully');
      } else if (response.statusCode == 404) {
        print('Parent not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //********************************UPDATE*********************************//

  Future<void> updateParentById(int id, String phone) async {
    final String apiUrl =
        '/api/v1/parentProfile/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        print('Parent updated successfully');
      } else if (response.statusCode == 404) {
        print('Parent not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
