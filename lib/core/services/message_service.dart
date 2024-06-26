import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class MessageService {
  final String apiUrl = "/api/v1/message";

  Future<bool> sendMessage(String message, int tripId) async {
    bool result = false;
    try {
      final response = await http.post(
        Uri.parse(url + apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'tripId': tripId,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        result = data["success"];
      }

      return result;
    } catch (e) {
      if (kDebugMode) {
        print("ERROR: $e");
      }
      return false;
    }
  }
}
