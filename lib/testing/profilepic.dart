import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../core/models/fireBaseModels/parentfb.dart';

class ProfilePictureWidget extends StatefulWidget {
  @override
  State<ProfilePictureWidget> createState() => _ProfilePictureWidgetState();
}

class _ProfilePictureWidgetState extends State<ProfilePictureWidget> {
  List<Map<String, dynamic>> parentss = [];
  String? profilePicture;

  Future<void> fetchParentss() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance.collection('parents').get();

      List<ParentFB> fetchedParents = querySnapshot.docs
          .map<ParentFB>((doc) => ParentFB.fromFirestore(doc))
          .toList();

      setState(() {
        parentss = fetchedParents.map((parent) {
          return {
            'firebaseId': parent.firebaseId ?? '',
            'mysqlId': parent.mysqlId ?? '',
            'fname': parent.fname ?? '',
            'lname': parent.lname ?? '',
            'email': parent.email ?? '',
            'phone': parent.phone ?? '',
            'profilepicture': parent.profilepicture ?? '',
          };
        }).toList();
      });

      // Print parent names, IDs, and Firestore document IDs
      for (var parent in parentss) {
        profilePicture = parent['profilepicture'];
        print(
          'Parent ID: ${parent['id']}, Name: ${parent['fname']} ${parent['lname']}, MySQL ID: ${parent['mysqlId']}, Firestore Doc ID: ${parent['firebaseId']}',
        );
      }
    } catch (error) {
      print('Error fetching parents: $error');
      // Handle error as needed
    }
  }

  Widget showImage() {
    return Center(
      child: profilePicture != null && profilePicture!.isNotEmpty
          ? CircleAvatar(
              radius: 30,
              backgroundImage: MemoryImage(base64Decode(profilePicture!)),
            )
          : Text('No image selected'),
    );
  }

  // Widget showImage(Uint8List? imageData) {
  //   if (imageData != null && imageData.isNotEmpty) {
  //     return CircleAvatar(
  //       radius: 30,
  //       backgroundImage: MemoryImage(imageData),
  //     );
  //   } else {
  //     return Text('No image selected');
  //   }
  // }
  //
  //
  //
  // Future<Uint8List?> fetchImage(String? profilePicture) async {
  //   if (profilePicture != null && profilePicture.isNotEmpty) {
  //     // Decode the base64 string to Uint8List
  //     Uint8List bytes = base64Decode(profilePicture);
  //     return bytes;
  //   } else {
  //     return null;
  //   }
  // }

  @override
  void initState() {
    super.initState();
    fetchParentss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: parentss.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: showImage(),
            title:
                Text('${parentss[index]['fname']} ${parentss[index]['lname']}'),
            subtitle: Text('Email: ${parentss[index]['email']}'),
            // Add more details as needed
          );
        },
      ),
    );
  }
}
