
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';
//import 'dart:html' as html;

import 'package:image_picker/image_picker.dart';

void main() {
  runApp(const imageconverter());
}

class imageconverter extends StatelessWidget {
  const imageconverter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ImagePicker imagePicker = ImagePicker();
  Uint8List? bytes;
  Uint8List? _image;
  String? filepath;
  String? imagedata;

  // var image;
  XFile? _pickedImage;

  // void openImage() async {
  //   final picker = ImagePicker();
  //   _pickedImage = await picker.pickImage(source: ImageSource.gallery);
  //   print(_pickedImage!.path);
  //
  //   if (_pickedImage != null) {
  //
  //     html.Blob blob = await html.window.fetch(_pickedImage!.path!).then((response) => response.blob());
  //
  //     html.File file = html.File([blob], _pickedImage!.name); // Convert Blob to File
  //
  //     // Now you have the 'file' object which you can use
  //     print('file: $file');
  //     print('File name: ${file.name}');
  //     print('File size: ${file.size} bytes');
  //     print('File type: ${file.type}');
  //     html.FileReader reader = html.FileReader();
  //
  //     reader.onLoadEnd.listen((e) async {
  //       if (reader.readyState == html.FileReader.DONE) {
  //         // Read the result as bytes
  //         Uint8List bytess = reader.result as Uint8List;
  //         bytes = bytess;
  //         print(bytes);
  //
  //         // Encode the bytes to base64
  //         String base64Image = base64Encode(bytess);
  //
  //         // Now you have the base64 string which you can store in your database
  //         print('Base64 Image: $base64Image');
  //
  //         setState(() {
  //           _image = bytes;
  //           imagedata= base64Image;
  //
  //         });
  //       }
  //     });
  //
  //     reader.readAsArrayBuffer(file);
  //   } else {
  //     print("Image selection canceled.");
  //   }
  // }
  // Future<void> openImage() async {
  //   try {
  //     Uint8List? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery) as Uint8List?;
  //     if (pickedFile != null) {
  //
  //       print(bytes);
  //       bytes = pickedFile;
  //       setState(() {}); // Trigger a rebuild after setting bytes
  //     } else {
  //       print('No image is selected');
  //     }
  //   } catch (e) {
  //     print('No image is selected');
  //   }
  // }

  Widget showImage() {
    if (imagedata == null || imagedata!.isEmpty) {
      return Container(
        child: Text('No image selected'),
      );
    } else {
      return Container(
        height: 300,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Image.memory(
              base64Decode(imagedata!),
              fit: BoxFit.cover,
            ).image,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image encoding or decoding'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              bytes != null
                  ? Image.memory(
                bytes!,
                fit: BoxFit.cover,
              )
                  : Container(child: Text('No image selected')),
              ElevatedButton(
                onPressed:(){},
                child: Text('Select Image'),
              ),
              Text('Decoded image'),
              showImage(),
            ],
          ),
        ),
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:image_picker/image_picker.dart';
//
//
// class imageconverter extends StatelessWidget {
//   const imageconverter({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final ImagePicker imagePicker = ImagePicker();
//   String imagepath = "";
//   String base64String = "";
//   Uint8List? bytes;
//   Future<void> openImage() async {
//     try {
//       final XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
//       if (pickedFile != null) {
//         final File imagefile = File(pickedFile.path);
//         final Uint8List imagebytes = await imagefile.readAsBytes();
//         print(imagebytes);
//         bytes = imagebytes;
//         base64String = base64.encode(imagebytes);
//         print(base64String);
//         print(bytes);
//
//         setState(() {}); // Trigger a rebuild after setting base64String
//       } else {
//         print('No image is selected');
//       }
//     } catch (e) {
//       print('No image is selected');
//     }
//   }
//
//   Widget showImage(BuildContext context) {
//     if (base64String.isEmpty) {
//       return Container(
//         child: Text('No image selected'),
//       );
//     } else {
//       return Container(
//         height: 300,
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: MemoryImage(base64Decode(base64String)),
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image encoding or decoding'),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             children: [
//               imagepath != ""
//                   ? Image.file(File(imagepath))
//                   : Container(child: Text('No image selected')),
//               ElevatedButton(
//                 onPressed: openImage,
//                 child: Text('Select Image'),
//               ),
//               Text('Decoded image'),
//               showImage(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// // import 'dart:typed_data';
// //
// // import 'package:flutter/material.dart';
// // import 'dart:convert';
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Base64 Image Example',
// //       theme: ThemeData(primarySwatch: Colors.blue),
// //       home: Scaffold(
// //         appBar: AppBar(title: Text('Base64 Image Example')),
// //         body: Center(
// //           child: DecodedImageWidget(
// //             base64Image:
// //             "iVBORw0KGgoAAAANSUhEUgAAAtAAAAUACAYAAABuzmU9AAAABHNCSVQICAgIfAhkiAAAIABJREFUeJzs3XeAFPX9//HXbLk7OBBERAFRBFEUENBYsGFBvxALqDFfJZrYS6xBjVFiTKyxRI0xlmiMfiVGFEGRn11UJMSGoiAqSLEASlSk3t2Wef/+mJ3Zcnu3N9wdd+DzkYzLzXxm5jNlZ17z2dlZR5IJAAAAQINEWroCAAAAwMaEAA0AAACEQIAGAAAAQiBAAwAAACEQoAEAAIAQCNAAAABACARoAAAAIAQCNAAAABACARqSE5Ecp6VrAQAAsFEgQP/QOY6ibdvLiZe3dE0AAAA2CgToH7i2fQaq5+//oe7nXqdI23aSaIkGgE3dM888o/JyGk6A9UWA/sFy5JS30danXq6KHfqrw/5HqP0eB0uylq4YAKCZjRgxQpMmTfrBhmgzk1np811Dy+GHZ5MP0Lvvvnte15z8N9rG8mbbYsTP1Hbn3eVEY3KiUW194sWKddjCuycaALBJGzFihJ588slmCdEjR47U1KlTtWrVKq1cuVL33nuvKioq6h1njz320IsvvqiVK1dq1apVmjp1qo466qgmrxvQFEhKP0iO4lt2U6cfnyg5jhzHkZyI4lv1UOefnC1F2C0A4Idg+PDhevLJJ0uG2zBuvPFGPfnkkzrooIP03Xff6YwzztA555yj6urqesebOXOm/v73v2vFihVq3769DjroID311FO6/vrrm6xuaD4jRozQu+++q2Qymdeg2Jq75cuXa9y4cerYsWPo5SUpNZHCVufGbNDPP/+8uWurzQ89TmVdusu/59lxHMlMHYcepfLuPcW90ADwwzB8+HBNmjSpSUL0yJEj9etf/1qSNG7cOPXv31+PPfaYYrGYfvrTn+qRRx7R4sWLlUqltHbtWn3yySeaOHGiTjrpJMViMT366KPq37+/HnnkkWCal19+uY488shG1w3NZ/jw4TrhhBN0+OGHKx6Py8k0zrX2rlu3bpo",
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// class DecodedImageWidget extends StatelessWidget {
//   final String base64Image;
//
//   DecodedImageWidget({required this.base64Image});
//
//   @override
//   Widget build(BuildContext context) {
//     // Split the base64 string to get only the base64-encoded data
//     List<String> parts = base64Image.split(',');
//     String imageBase64 = parts.length > 1 ? parts[1] : base64Image;
//
//     // Decode the base64 string to bytes
//     Uint8List bytes = base64Decode(imageBase64);
//
//     // Create an Image.memory widget with the decoded bytes
//     return Image.memory(
//       bytes,
//       fit: BoxFit.cover,
//     );
//   }
// }
