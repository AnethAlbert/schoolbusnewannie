
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newschoolbusapp/models/station.dart';



class StationApiService {
  //final String url = "http://192.168.98.168:8080";
  //final String url = "http://192.168.43.168:8080";
   // final String url = "http://192.168.1.79:8080";
  //final String url = "http://192.168.103.168:8080";
  // final String url = "http://192.168.1.79:8080";
  //  final String url = "http://192.168.1.79:8080";
  //final String url = "http://192.168.100.26:8080";
  //final String url = "http://192.168.43.26:8080";
  //final String url = "http://192.168.100.209:8080";
  // final String url = "http://172.20.10.8:8080";
  //final String url = "http://192.168.100.209:8080";
  //final String url = "http://192.168.100.219:8080";
  final String url = "http://192.168.37.55:8080";
  final String apiUrl = "/api/v1/station";
//192.168.100.26

//************************INSERT************************



  Future<Station> addStation(String code, String name, BuildContext context) async {
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


        // You need to return a Class here
        return Station(/* initialize Class object with required data */);
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
  Future<List<Station>> getAllStations() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Station.fromJson(json)).toList();
      } else {
        throw Exception('Error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw Exception('Error occurred');
    }
  }

//******************************GET BY ID*******************//
  Future<List<Station>?> getStationById(int id) async {
    final String apiUrl = '/api/v1/station/$id'; // Include the ID in the URL

    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Station.fromJson(json)).toList();
      } else if (response.statusCode == 404) {
        // Station not found
        print('Station not found');
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

  Future<void> removeStationById(int id) async {
    final String apiUrl = '/api/v1/station/$id'; // Include the ID in the URL

    try {
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Station deleted successfully');
      } else if (response.statusCode == 404) {
        print('Station not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

//********************************UPDATE*********************************//

  Future<void> updateStationById(int id, String name) async {
    final String apiUrl = '/api/v1/station/$id'; // Include the ID in the URL

    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name}),
      );

      if (response.statusCode == 200) {
        print('Station updated successfully');
      } else if (response.statusCode == 404) {
        print('Station not found');
      } else {
        throw Exception('Unexpected error occurred');
      }
    } catch (error) {
      print('Error: $error');
    }
  }


}





