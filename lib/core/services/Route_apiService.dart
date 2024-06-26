import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/route.dart';
import '../utils/constants.dart';

class RouteApiService {
  final String apiUrl = "/api/v1/route";

//192.168.100.26

//************************INSERT************************

  Future<RouteClass> addRoute(
      String code, String name, BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'code': code,
          'name': name,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);

        // You need to return a Route here
        return RouteClass(/* initialize Route object with required data */);
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

  Future<List<RouteClass>> getAllRoutes() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => RouteClass.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

//******************************GET PARENT BY ID*******************//

  Future<RouteClass?> getRouteById(int id) async {
    final String apiUrl = '/api/v1/route/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return RouteClass.fromJson(json);
      } else if (response.statusCode == 404) {
        // Route not found
        print('Route not found');
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

  Future<void> removeRouteById(int id) async {
    final String apiUrl = '/api/v1/routes/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Route deleted successfully');
      } else if (response.statusCode == 404) {
        print('Route not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

//********************************UPDATE*********************************//
  Future<void> updateRouteById(int id, String name) async {
    final String apiUrl = '/api/v1/route/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        print('Route updated successfully');
      } else if (response.statusCode == 404) {
        print('Route not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
