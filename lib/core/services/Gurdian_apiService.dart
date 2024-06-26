import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/gurdian.dart';
import '../utils/constants.dart';

class GardianApiService {
  final String apiUrl = "/api/v1/gurdianProfile";
  final String apiUrll = "/api/v1/login_session";

//192.168.100.26

  ///**************sharedPrefference******************

  Future<String?> getTokenFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<Gurdian> getUserFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return Gurdian(
      id: prefs.getInt('pref_id'),
      fname: prefs.getString('pref_fname'),
      lname: prefs.getString('pref_lname'),
      email: prefs.getString('pref_email'),
      phone: prefs.getString('pref_phone'),
      role: prefs.getString('pref_role'),
      profilepicture: prefs.getString('pref_profilepicture'),
    );
  }

  Uint8List? _decodeProfilePicture(List<String>? bytes) {
    if (bytes == null || bytes.isEmpty) {
      return null;
    }
    // Convert List<String> back to List<int> and then to Uint8List
    List<int> byteList = bytes.map((str) => int.parse(str)).toList();
    return Uint8List.fromList(byteList);
  }

  Future<void> saveUserToPrefs(Gurdian gurdian) async {
    final prefs = await SharedPreferences.getInstance();

    if (gurdian.id != null) {
      prefs.setInt('gurdianId_SPc', gurdian.id!);
    }
    if (gurdian.fname != null) {
      prefs.setString('fname_SPc', gurdian.fname!);
    }
    if (gurdian.lname != null) {
      prefs.setString('lname_SPc', gurdian.fname!);
    }
    if (gurdian.email != null) {
      prefs.setString('email_SPc', gurdian.email!);
    }
    if (gurdian.phone != null) {
      prefs.setString('phone_SPc', gurdian.phone!);
    }
    if (gurdian.profilepicture != null) {
      prefs.setString('profilepicture_SPc', gurdian.profilepicture!);
    }

    if (gurdian.digitalfingerprint != null) {
      prefs.setString('digitalfingerprint_SPc', gurdian.digitalfingerprint!);
    }
  }

  /////****************sp****************************

//************************INSERT************************

  Future<Map<String, dynamic>?> loginUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url + apiUrll),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful login
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String? token = responseData['token'];

        // Decode the JWT token to extract user information
        Map<String, dynamic> decodedToken = _decodeToken(token);

        // Save user information to shared preferences
        // Gurdian gurdian = Gurdian.fromJson(decodedToken);
        // await saveUserToPrefs(gurdian);

        return decodedToken;
      } else {
        // Handle other status codes
        print('Login failed: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error during login: $error');
      return null;
    }
  }

  Map<String, dynamic> _decodeToken(String? token) {
    if (token == null) {
      throw Exception('Token is null');
    }

    List<String> tokenParts = token.split('.');
    if (tokenParts.length != 3) {
      throw Exception('Invalid token format');
    }

    String payloadBase64 = tokenParts[1];
    String normalizedPayload = base64Url.normalize(payloadBase64);
    Map<String, dynamic> decodedPayload =
        jsonDecode(utf8.decode(base64Url.decode(normalizedPayload)));

    return decodedPayload;
  }

  ///**************************ADDGURDIAN****************************************
  ///
  ///
  Future<Gurdian> addGurdian({
    required String fname,
    required String lname,
    required String email,
    required String phone,
    required String profilePicture,
    required String digitalFingerprint,
    required String role,
    required String password,
    required BuildContext context,
  }) async {
    var body = jsonEncode(<String, dynamic>{
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      // 'profilepicture': profilePicture,
      'digitalfingerprint': digitalFingerprint,
      'role': role,
      'password': password,
    });
    print("BODY: $body");

    try {
      var response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: body,
      );

      if (response.statusCode == 201) {
        var jsonData = jsonDecode(response.body);
        var token = jsonData['token'];
        var message = jsonData['message'];
        var user = jsonData['user'];

        // Extract the ID from the user object
        int mysqlId = user['id']; // Assuming the ID key is 'id'

        // Create a Gurdian object with the received ID
        Gurdian newGurdian = Gurdian(
          id: mysqlId,
          fname: fname,
          lname: lname,
          email: email,
          phone: phone,
          profilepicture: profilePicture,
          digitalfingerprint: digitalFingerprint,
          role: role,
          password: password,
          // You can set other properties here as needed
        );

        return newGurdian;
      } else {
        var jsonData = jsonDecode(response.body);
        String errorMessage = jsonData['error'];
        if (errorMessage == null || errorMessage.isEmpty) {
          print("MySql ERROR: $errorMessage");
          errorMessage = 'An error occurred';
        }
        throw Exception(errorMessage);
      }
    } catch (e) {
      print(e);
      throw Exception('Error while connecting to API');
    }
  }

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

  // Future<Map<String, dynamic>> addFingerPrint(int? fingerPrintId) async {
  //   final String apiUrl = '/api/v1/enroll';
  //
  //   try {
  //     if (fingerPrintId != null) { // Check if fingerPrintId is not null
  //       final response = await http.post(
  //         Uri.parse(url + apiUrl),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json',
  //         },
  //         body: jsonEncode(<String, dynamic>{
  //           'FingerPrintid': fingerPrintId.toString(), // Convert to string
  //         }),
  //       );
  //
  //       if (response.statusCode == 200) {
  //         // Fingerprint added successfully
  //         return {'success': true, 'message': 'Fingerprint added successfully'};
  //       } else {
  //         throw Exception('Failed to add fingerprint ID: ${response.statusCode}');
  //       }
  //     } else {
  //       throw Exception('Fingerprint ID is null or undefined');
  //     }
  //   } catch (error) {
  //     throw Exception('Failed to add fingerprint ID: $error');
  //   }
  // }

  // Future<Gurdian> addGurdian(
  //     String fname,
  //     String lname,
  //     String email,
  //     String phone,
  //     String profilepicture,
  //     String digitalfingerprint,
  //     String role,
  //     String password,
  //     BuildContext context) async {
  //   try {
  //     var response = await http.post(
  //       Uri.parse(url + apiUrl),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode(<String, dynamic>{
  //         'fname': fname,
  //         'lname': lname,
  //         'email': email,
  //         'phone': phone,
  //         'profilepicture': profilepicture,
  //         'digitalfingerprint': digitalfingerprint,
  //         'role': role,
  //         'password': password,
  //       }),
  //     );
  //
  //     if (response.statusCode == 201) {
  //       var jsonData = jsonDecode(response.body);
  //       var token = jsonData['token'];
  //       var message = jsonData['message'];
  //       var user12 = jsonData['user'];
  //
  //       // You need to return a Gurdian here
  //       return Gurdian(/* initialize Gurdian object with required data */);
  //     } else {
  //       var jsonData = jsonDecode(response.body);
  //       String errorMessage = jsonData['error'];
  //       if (errorMessage == null || errorMessage.isEmpty) {
  //         errorMessage = 'An error occurred';
  //       }
  //       throw Exception(errorMessage);
  //     }
  //   } catch (e) {
  //     print(e);
  //     throw Exception('Error while connecting to API');
  //   }
  // }
//**************************************GETBYID*************************
  Future<String?> getProfilePictureById(int id) async {
    final String apiUrlid =
        '/api/v1/gurdianProfile/$id/profilepicture'; // Update the API URL with the correct ID

    try {
      final response = await http.get(
        Uri.parse(url + apiUrlid),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Parse and return the profile picture URL or base64-encoded image
        return jsonDecode(response.body)['profilepicture'];
      } else {
        throw Exception('Failed to load profile picture');
      }
    } catch (e) {
      throw Exception('Failed to load profile picture: $e');
    }
  }

  //*************GET********************

  Future<List<Gurdian>> getAllGuardians() async {
    try {
      final response = await http.get(
        Uri.parse(url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON array
        List<dynamic> jsonList = jsonDecode(response.body);
        List<Gurdian> guardians =
            jsonList.map((json) => Gurdian.fromJson(json)).toList();
        print("GUARDIANS: $guardians");
        return guardians;
      } else {
        // Handle other status codes, e.g., 500 for internal server error
        print('Error: ${response.statusCode}');
        return []; // You might want to throw an exception or handle errors differently
      }
    } catch (error) {
      print('Error: $error');
      return []; // You might want to throw an exception or handle errors differently
    }
  }

//*************************GET BY ID ************************************
  Future<Gurdian?> getGurdianById(int id) async {
    final String apiUrlid = '/api/v1/gurdianProfile/$id';

    try {
      final response = await http.get(
        Uri.parse(apiUrlid),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, parse the JSON object
        Map<String, dynamic> json = jsonDecode(response.body);
        return Gurdian.fromJson(json);
      } else if (response.statusCode == 404) {
        // Guardian not found
        print('Gurdian not found');
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

  //********************************* DeleteById*********************//

  Future<void> removeGurdianById(int id) async {
    final String apiUrlid = '/api/v1/gurdianProfile/$id';

    try {
      final response = await http.delete(
        Uri.parse(apiUrlid),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Successful response, print a success message
        print('Gurdian deleted successfully');
      } else if (response.statusCode == 404) {
        // Guardian not found
        print('Gurdian not found');
      } else {
        // Handle other status codes, e.g., 500 for internal server error
        print('Error: ${response.statusCode}');
        // You might want to throw an exception or handle errors differently
      }
    } catch (error) {
      print('Error: $error');
      // You might want to throw an exception or handle errors differently
    }
  }

  //***************************************UPDATE BY ID*************************************

  Future<void> updateGuardianById(int id, String phone) async {
    final String apiUrl = '/api/v1/gurdianProfile/$id';
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'phone': phone}),
      );

      if (response.statusCode == 200) {
        // Successful response, print a success message
        print('Guardian updated successfully');
      } else if (response.statusCode == 404) {
        // Guardian not found
        print('Guardian not found');
      } else {
        // Handle other status codes, e.g., 500 for internal server error
        print('Error: ${response.statusCode}');
        // You might want to throw an exception or handle errors differently
      }
    } catch (error) {
      print('Error: $error');
      // You might want to throw an exception or handle errors differently
    }
  }
}
