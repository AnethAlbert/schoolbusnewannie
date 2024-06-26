import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/bus.dart';
import '../utils/constants.dart';

class ApiService {
  final String apiUrl = "/api/v1/bus";

//192.168.100.26

//************************INSERT************************

  Future<Bus> addBus(String registration_number, String model, int capacity,
      BuildContext context) async {
    try {
      var response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'registration_number': registration_number,
          'model': model,
          'capacity': capacity,
        }),
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var token = jsonData['token'];
        var message = jsonData['message'];
        var user12 = jsonData['user'];

        // You need to return a Bus here
        return Bus(/* initialize Bus object with required data */);
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

////*****************************GET***************************************
  Future<List<Bus>> getAllBuses() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Bus.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

//******************************************GET BY ID**************************

  Future<Bus?> getBusById(int id) async {
    final String apiUrl = '/api/v1/bus/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return Bus.fromJson(json);
      } else if (response.statusCode == 404) {
        // Bus not found
        print('Bus not found');
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

  //************************************DELETE***********************************

  Future<void> removeBusById(int id) async {
    final String apiUrl = '/api/v1/bus/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Bus deleted successfully');
      } else if (response.statusCode == 404) {
        print('Bus not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  //****************************UPDATE*****************************************

  Future<void> updateBusById(int id, int capacity) async {
    final String apiUrl = '/api/v1/bus/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'capacity': capacity}),
      );

      if (response.statusCode == 200) {
        print('Bus updated successfully');
      } else if (response.statusCode == 404) {
        print('Bus not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
