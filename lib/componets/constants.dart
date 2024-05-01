import 'package:flutter/material.dart';
import 'package:newschoolbusapp/secrets.dart';

const String ApiKey = Secrets.API_KEY;
 Color PrimaryColor = Color(0xFF7B61FF);
 const double defaultPadding =16.0;

const String GOOGLE_MAPS_API_KEY = Secrets.API_KEY;


class DottedLinePainter extends CustomPainter {
 @override
 void paint(Canvas canvas, Size size) {
  final Paint paint = Paint()
   ..color = Colors.black // Adjust the color of the line
   ..strokeWidth = 2 // Adjust the width of the line
   ..strokeCap = StrokeCap.round;

  const double dashWidth = 5.0;
  const double dashSpace = 5.0;

  double startX = 0.0;
  while (startX < size.width) {
   canvas.drawLine(
    Offset(startX, 0),
    Offset(startX + dashWidth, 0),
    paint,
   );
   startX += dashWidth + dashSpace;
  }
 }

 @override
 bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
 }
}

class VerticalDottedLinePainter extends CustomPainter {
 @override
 void paint(Canvas canvas, Size size) {
  final Paint paint = Paint()
   ..color = Colors.black // Adjust the color of the line
   ..strokeWidth = 2 // Adjust the width of the line
   ..strokeCap = StrokeCap.round;

  const double dashHeight = 5.0;
  const double dashSpace = 5.0;

  double startY = 0.0;
  while (startY < size.height) {
   canvas.drawLine(
    Offset(0, startY),
    Offset(0, startY + dashHeight),
    paint,
   );
   startY += dashHeight + dashSpace;
  }
 }

 @override
 bool shouldRepaint(CustomPainter oldDelegate) {
  return false;
 }
}