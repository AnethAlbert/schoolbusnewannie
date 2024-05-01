// import 'package:flutter/material.dart';
//
// class RPSCustomPainter extends CustomPainter{
//
//   @override
//   void paint(Canvas canvas, Size size) {
//
//
//
//     // Layer 1
//
//     Paint paint_fill_0 = Paint()
//       ..color = const Color.fromARGB(255, 255, 255, 255)
//       ..style = PaintingStyle.fill
//       ..strokeWidth = size.width*0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;
//
//
//     Path path_0 = Path();
//     path_0.moveTo(size.width*0.2916667,size.height*0.3571429);
//     path_0.lineTo(size.width*0.6250000,size.height*0.3585714);
//     path_0.lineTo(size.width*0.6250000,size.height*0.7142857);
//     path_0.lineTo(size.width*0.4575000,size.height*0.5728571);
//     path_0.lineTo(size.width*0.2900000,size.height*0.7128571);
//
//     canvas.drawPath(path_0, paint_fill_0);
//
//
//     // Layer 1
//
//     Paint paint_stroke_0 = Paint()
//       ..color = const Color.fromARGB(255, 33, 150, 243)
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = size.width*0.00
//       ..strokeCap = StrokeCap.butt
//       ..strokeJoin = StrokeJoin.miter;
//
//
//
//     canvas.drawPath(path_0, paint_stroke_0);
//
//
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
//
// }
//



//*****************************clipPath
import 'package:flutter/material.dart';

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Start at the bottom-left
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(size.width, 0); // Top-right
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.5, 0, 0); // Custom curve
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

//******************************************