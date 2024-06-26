import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/ui/bucketliveMap03/BucketMap03.dart';

class ParentCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String? profilepicture;
  final VoidCallback onPressed;

  // final String profilePicture;

  const ParentCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    this.profilepicture,
    required this.onPressed,
    // required this.profilePicture,
  }) : super(key: key);

  // Widget showImage() {
  //   return Center(
  //     child: profilepicture != null && profilepicture!.isNotEmpty
  //         ? CircleAvatar(
  //       radius: 30,
  //       backgroundImage: MemoryImage(base64Decode(profilepicture!)),
  //     )
  //         : Text('No image selected'),
  //   );
  // }

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
      elevation: 10.0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: FutureBuilder<Widget>(
            future: showImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(); // Placeholder while loading
              } else {
                if (snapshot.hasError) {
                  return const Text('Error loading image'); // Handle error
                } else {
                  return snapshot.data!; // Return the image widget
                }
              }
            },
          ),

          // CircleAvatar(
          //       radius: 36,
          //       backgroundImage: AssetImage('assets/images/parent.jpg'),
          //     ),
          // CircleAvatar(
          //   radius: 36,
          //   backgroundImage: NetworkImage(
          //     'https://media.istockphoto.com/id/1353379172/photo/cute-little-african-american-girl-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=KI0p6tdb1rV8Uj-A9095dhtlD6RYSQcILmbCJgfPMMU=',
          //   ),
          // ),
          title: Text(
            firstName,
            style: const TextStyle(fontSize: 14.0),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                email,
                maxLines: 1,
                style: const TextStyle(
                  fontSize: 12.0,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                phone,
                style: const TextStyle(fontSize: 12.0),
              ),
            ],
          ),
          trailing: SizedBox(
            width: 90,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.linearMiddle,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'next',
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
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
