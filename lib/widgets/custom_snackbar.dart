import 'package:flutter/material.dart';

Future customSnackBar(
    BuildContext context, String message, Color? color) async {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color,
    ),
  );
}
