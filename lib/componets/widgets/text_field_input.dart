// import 'package:flutter/material.dart';
//
// class TextFieldInput extends StatelessWidget {
//   final TextEditingController textEditingController;
//   final bool ispass;
//   final String hintText;
//   final TextInputType textInputType;
//   final bool readOnly; // Add a boolean flag for read-only mode
//    final GestureTapCallback? onTap;  // Add onTap callback
//
//   TextFieldInput({
//     required this.textEditingController,
//     this.ispass = false,
//     required this.hintText,
//     required this.textInputType,
//     this.readOnly = false, // Initialize read-only flag
//     this.onTap, required String? Function(dynamic value) validator, // Initialize onTap callback
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final inputBorder = OutlineInputBorder(
//       borderSide: BorderSide(
//         width: 1.0, // Adjust the border width here
//         color: Colors.grey, // Customize the border color if needed
//       ),
//     );
//     return GestureDetector(
//       child: TextField(
//         controller: textEditingController,
//         decoration: InputDecoration(
//           hintText: hintText,
//           border: inputBorder,
//           focusedBorder: inputBorder,
//           enabledBorder: inputBorder,
//           filled: true,
//           labelStyle: TextStyle(color: Colors.black),
//           // Adjust content padding to make TextField smaller
//           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
//           // You can adjust the font size to make text smaller
//           // style: TextStyle(fontSize: 14),
//         ),
//         keyboardType: textInputType,
//         obscureText: ispass,
//         readOnly: readOnly, // Set read-only mode based on the flag
//         onTap: onTap,
//
//
//       ),
//     );
//   }
// }


///********************************************************************************
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool ispass;
  final String hintText;
  final TextInputType textInputType;
  final bool readOnly;
  final GestureTapCallback? onTap;
  final String? Function(String?)? validator;

  TextFieldInput({
    required this.textEditingController,
    this.ispass = false,
    required this.hintText,
    required this.textInputType,
    this.readOnly = false,
    this.onTap,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        width: 1.0, // Adjust the border width here
        color: Colors.grey, // Customize the border color if needed
      ),
    );
    return GestureDetector(
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
          hintText: hintText,
          border: inputBorder,
          focusedBorder: inputBorder,
          enabledBorder: inputBorder,
          filled: true,
          labelStyle: TextStyle(color: Colors.black),
          // Adjust content padding to make TextFormField smaller
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          // You can adjust the font size to make text smaller
          // style: TextStyle(fontSize: 14),
        ),
        keyboardType: textInputType,
        obscureText: ispass,
        readOnly: readOnly,
        onTap: onTap,
        validator: validator,
      ),
    );
  }
}

//
//
//
//
//
//
//
//
//
// // import 'package:flutter/material.dart';
// //
// // class TextFieldInput extends StatelessWidget {
// //   final TextEditingController textEditingController;
// //   final bool ispass;
// //   final String hintText;
// //   final TextInputType textInputType;
// //   final bool readOnly; // Add a boolean flag for read-only mode
// //    final GestureTapCallback? onTap;  // Add onTap callback
// //
// //   TextFieldInput({
// //     required this.textEditingController,
// //     this.ispass = false,
// //     required this.hintText,
// //     required this.textInputType,
// //     this.readOnly = false, // Initialize read-only flag
// //     this.onTap, // Initialize onTap callback
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final inputBorder = OutlineInputBorder(
// //       borderSide: BorderSide(
// //         width: 1.0, // Adjust the border width here
// //         color: Colors.grey, // Customize the border color if needed
// //       ),
// //     );
// //     return GestureDetector(
// //       child: TextField(
// //         controller: textEditingController,
// //         decoration: InputDecoration(
// //           hintText: hintText,
// //           border: inputBorder,
// //           focusedBorder: inputBorder,
// //           enabledBorder: inputBorder,
// //           filled: true,
// //           labelStyle: TextStyle(color: Colors.black),
// //           // Adjust content padding to make TextField smaller
// //           contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
// //           // You can adjust the font size to make text smaller
// //           // style: TextStyle(fontSize: 14),
// //         ),
// //         keyboardType: textInputType,
// //         obscureText: ispass,
// //         readOnly: readOnly, // Set read-only mode based on the flag
// //         onTap: onTap,
// //
// //
// //       ),
// //     );
// //   }
// // }
