import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class StudentCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int age;
  final String? profilepicture;
  final VoidCallback onPressed;

  const StudentCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.age,
    this.profilepicture,
    required this.onPressed,
  }) : super(key: key);

  Future<Widget> showImage() async {
    if (profilepicture != null && profilepicture!.isNotEmpty) {
      // Load profile picture asynchronously
      Uint8List imageData = await fetchImage(profilepicture!);
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(imageData),
      );
    } else {
      return Center(
        child: Text('No image selected'),
      );
    }
  }

  Future<Uint8List> fetchImage(String profilepicture) async {
    Uint8List imageData = base64Decode(profilepicture);
    return imageData;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 22.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          leading: FutureBuilder<Widget>(
            future: showImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Placeholder while loading
              } else {
                if (snapshot.hasError) {
                  return Text('Error loading image'); // Handle error
                } else {
                  return snapshot.data!; // Return the image widget
                }
              }
            },
          ),
          title: Text(
            '$firstName $lastName',
            style: TextStyle(fontSize: 14.0),
          ),
          subtitle: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Age: $age',
                  style: TextStyle(fontSize: 14.0),
                ),
              ],
            ),
          ),
          trailing: Container(
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  child: Text(
                    'track',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
