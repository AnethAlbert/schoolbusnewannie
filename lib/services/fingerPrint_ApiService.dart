

import 'dart:convert';
import 'package:http/http.dart' as http;

class FingerPrintApiService {

  //final String url = "http://172.20.10.8:8080";
  //final String url = "http://192.168.100.209:8080";
  // final String url = "http://192.168.100.219:8080";
  //final String url = "http://192.168.37.55:8080";
  final String url = "http://192.168.135.55:8080";
  //final String url = "http://192.168.43.26:8080";

  final String apiUrl = "/api/v1/detection";

  Future<Map<String, dynamic>> addFingerPrint(int fingerPrintId) async {
    final String apiUrl = '/api/v1/Enroll-capture-fingerprint';

    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'FingerPrintid': fingerPrintId.toString(), // Convert to string
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

  static Future<String?> getFingerprintID() async {
    final String apiUrl = "/api/v1/detection";

    try {
      final response = await http.get(
        Uri.parse(FingerPrintApiService().url + apiUrl),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Return the response body as a string
        return response.body;
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
}

















// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// class FingerPrintApiService {
//
//   final String url = "http://172.20.10.8:8080";
//
//   final String apiUrl = "/api/v1/detection";
//
//   Future<Map<String, dynamic>> addFingerPrint(int fingerPrintId) async {
//     final String apiUrl = '/api/v1/Enroll-capture-fingerprint';
//
//     try {
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
//     } catch (error) {
//       throw Exception('Failed to add fingerprint ID: $error');
//     }
//   }
//
//   static Future<String?> getFingerprintID() async {
//     // Replace this with your actual API endpoint
//
//     try {
//       final response = await http.get(
//         Uri.parse(apiUrl + '/detection'),
//         headers: {'Content-Type': 'application/json'},
//       );
//
//       if (response.statusCode == 200) {
//         // Successful response, parse the JSON to get fingerprint ID
//         Map<String, dynamic> jsonResponse = jsonDecode(response.body);
//         String? fingerprintID = jsonResponse['fingerprintID'];
//         return fingerprintID;
//       } else {
//         // Handle other status codes, e.g., 500 for internal server error
//         print('Error: ${response.statusCode}');
//         return null; // You might want to throw an exception or handle errors differently
//       }
//     } catch (error) {
//       print('Error: $error');
//       return null; // You might want to throw an exception or handle errors differently
//     }
//   }
//
// }