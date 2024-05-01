import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/widgets/serchTextfield.dart';
import 'package:newschoolbusapp/widgets/studentListToParentBuilder.dart';

class ParentStudentListView extends StatefulWidget {
  final int parentId;
  final String firstName;
  final String lastName;
  final String email;
  final String profilepicture;

  const ParentStudentListView({Key? key, required this.parentId, required this.firstName, required this.lastName, required  this.email,
    required this.profilepicture
  }) : super(key: key);

  @override
  State<ParentStudentListView> createState() => _ParentStudentListViewState();
}

class _ParentStudentListViewState extends State<ParentStudentListView> {
  Future<Widget> showImage() async {
    if (widget.profilepicture != null && widget.profilepicture!.isNotEmpty) {
      // Load profile picture asynchronously
      Uint8List imageData = await fetchImage(widget.profilepicture!);
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




  //int? parentId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Hero(
          tag: 'parentHeroid',
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: 300,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0,left: 8,right: 8,bottom: 8),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          FutureBuilder<Widget>(
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
                          // CircleAvatar(
                          //   radius: 30, // Adjust the radius as needed
                          //   backgroundImage: NetworkImage(
                          //       'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'), // Replace with your avatar image URL
                          // ),
                        ),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,children: [
                          Text('ParentId : ${widget.parentId}'),
                          Text(' ${widget.firstName}'),
                          Text('${widget.email}'),
                        ])
                      ],
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    serchTextfield(parentId:widget.parentId),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white70
                          ),
                          child: Center(child: Text("Below are Students Related to  ${widget.firstName} ${widget.lastName} "))),
                    ),
                    StudentListBuilder(parent_id: widget.parentId)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
