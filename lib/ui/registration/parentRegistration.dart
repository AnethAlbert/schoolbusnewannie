import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newschoolbusapp/componets/utils/colors.dart';
import 'package:newschoolbusapp/componets/widgets/text_field_input.dart';
import 'package:newschoolbusapp/models/fireBaseModels/parentfb.dart';
import 'package:newschoolbusapp/models/parent.dart';
import 'package:newschoolbusapp/services/firebaseservices/parent_database_service.dart';
import 'package:newschoolbusapp/ui/bucket/bucketnew.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/gurdian/registrationRoom.dart';
import 'package:newschoolbusapp/ui/login_page.dart';
import 'package:newschoolbusapp/utils/utils.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';

//import 'dart:html' as html;
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/Parent_apiService.dart';

class ParentRegistrationClass extends StatefulWidget {
  const ParentRegistrationClass({Key? key}) : super(key: key);

  @override
  State<ParentRegistrationClass> createState() =>
      _ParentRegistrationClassState();
}

class _ParentRegistrationClassState extends State<ParentRegistrationClass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  bool isLoading = false;
  final ParentApiService _apiService = ParentApiService();
  final ParentDatabaseService _databaseService = ParentDatabaseService();
  String? imagedata;

  // var image;
  XFile? _pickedImage;

  List<String> roles = ['Teacher', 'Head Teacher'];
  String? selectedIttem = 'Teacher';

  Future<Position> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _profilePictureController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      XFile imageFile = XFile(pickedImage.path);

      // Read the file as bytes
      Uint8List bytes = await imageFile.readAsBytes();
      print(bytes);

      // Encode the bytes to base64
      String base64Image = base64Encode(bytes);

      // Now you have the base64 string which you can store in your database
      print('Base64 Image: $base64Image');

      setState(() {
        _pickedImage = pickedImage;
        _image = bytes;
        imagedata = base64Image;
      });
    }
  }

  // void selectImage() async {
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
  //         Uint8List bytes = reader.result as Uint8List;
  //         print(bytes);
  //
  //         // Encode the bytes to base64
  //         String base64Image = base64Encode(bytes);
  //
  //         // Now you have the base64 string which you can store in your database
  //         print('Base64 Image: $base64Image');
  //
  //         setState(() {
  //             _image = bytes;
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

  Future<void> singUpUser() async {
    setState(() {
      isLoading = true;
    });
    Position position = await _getCurrentLocation();

    try {
      // Convert Uint8List to base64-encoded String
      String base64Image = base64Encode(_image!);

      // Create a Guardian object
      Parent parent = Parent(
        fname: _firstNameController.text,
        lname: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        profilepicture: base64Image,
        password: _passwordController.text,
        timestamp: DateTime.now(),
      );

      // Add the Guardian to MySQL using ApiService
      Parent savedParent = await _apiService.addParent(
        fname: parent.fname!,
        lname: parent.lname!,
        email: parent.email!,
        phone: parent.phone!,
        profilePicture: parent.profilepicture!,
        password: parent.password!,
        context: context,
      );

      // Retrieve the ID of the saved Guardian
      int mysqlId = savedParent.id!;

      // Register user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: parent.email!, password: parent.password!);

      // Get the Firebase User ID
      String firebaseUserId = userCredential.user!.uid;

      // Create a GuardianFB object for Firebase
      ParentFB parentFB = ParentFB(
        firebaseId: firebaseUserId,
        mysqlId: mysqlId,
        fname: parent.fname!,
        lname: parent.lname!,
        email: parent.email!,
        phone: parent.phone!,
        profilepicture: parent.profilepicture!,
        timestamp: parent.timestamp!,
        latitude: position.latitude,
        longitude: position.longitude,
      );
      // Insert the GuardianFB object into Firestore with user.uid as document ID
      await FirebaseFirestore.instance
          .collection('parents')
          .doc(firebaseUserId) // Use user.uid as the document ID
          .set(parentFB.toJson());

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => registrationRoom()));
    } catch (error) {
      showSnackBar("Error occurred: $error", context);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigatetologin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => noSummaryClass(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
            padding: EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(child: Text("Parent Registration")),
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 64, backgroundImage: MemoryImage(_image!))
                          : const CircleAvatar(
                              radius: 64,
                              backgroundImage: NetworkImage(
                                  "https://t3.ftcdn.net/jpg/03/46/83/96/240_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg"),
                            ),
                      Positioned(
                          bottom: -10,
                          left: 80,
                          child: IconButton(
                            onPressed: () {
                              selectImage();
                              // selectImageWeb();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              size: 25,
                            ),
                          ))
                    ]),
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                      textEditingController: _firstNameController,
                      hintText: "first name",
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null; // Return null if validation passes
                      },
                      onTap: () {
                        print("first name is tapped");
                      }),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _lastNameController,
                    hintText: "last name",
                    // textInputType: TextInputType.visiblePassword,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _emailController,
                    hintText: "email",
                    // textInputType: TextInputType.visiblePassword,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _phoneController,
                    hintText: "phone",
                    // textInputType: TextInputType.visiblePassword,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "password",
                    // textInputType: TextInputType.visiblePassword,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null; // Return null if validation passes
                    },
                    ispass: true,
                  ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: isLoading
                        ? Container(
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Waiting "),
                                  SizedBox(width: 2),
                                  SpinKitWave(color: Colors.white, size: 30),
                                  // Add more widgets if needed
                                ],
                              ),
                            ),
                          )
                        : Container(
                            //margin: EdgeInsets.only(top: 10.0),
                            decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                  color: Theme.Colors.loginGradientStart,
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 20.0,
                                ),
                                BoxShadow(
                                  color: Theme.Colors.loginGradientEnd,
                                  offset: Offset(1.0, 6.0),
                                  blurRadius: 20.0,
                                ),
                              ],
                              gradient: new LinearGradient(
                                  colors: [
                                    Theme.Colors.loginGradientEnd,
                                    Theme.Colors.loginGradientStart
                                  ],
                                  begin: const FractionalOffset(0.2, 0.2),
                                  end: const FractionalOffset(1.0, 1.0),
                                  stops: [0.0, 1.0],
                                  tileMode: TileMode.clamp),
                            ),
                            child: MaterialButton(
                                highlightColor: Colors.transparent,
                                splashColor: Theme.Colors.loginGradientEnd,
                                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 42.0),
                                  child: Text(
                                    "SIGN UP",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25.0,
                                        fontFamily: "WorkSansBold"),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    print("Enock");
                                    singUpUser();
                                  }

                                }),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }

  void showDropdownMenu(BuildContext context) {
    DropdownButton<String>(
        value: selectedIttem,
        items: roles
            .map((role) => DropdownMenuItem<String>(
                  value: role,
                  child: Text(role, style: TextStyle(fontSize: 24)),
                ))
            .toList(),
        onChanged: (role) => setState(() {
              selectedIttem = role;
            }));
  }
}

////**********************************************END********************************************************?????/////////////////
// TextFormField(
// controller: _firstNameController,
// decoration: InputDecoration(
// hintText: "First Name",
// border:
// OutlineInputBorder(), // You can customize the border here
// ),
// keyboardType: TextInputType.text,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your first name';
// }
// return null; // Return null if validation passes
// },
// onTap: () {
// print("First name is tapped");
// },
// ),
// const SizedBox(height: 18),
// TextFormField(
// controller: _lastNameController,
// decoration: InputDecoration(
// hintText: "Last Name",
// border: OutlineInputBorder(), // Customize the border here
// ),
// keyboardType: TextInputType.text,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your last name';
// }
// return null; // Return null if validation passes
// },
// ),
// const SizedBox(height: 18),
// TextFormField(
// controller: _emailController,
// decoration: InputDecoration(
// hintText: "Email",
// border: OutlineInputBorder(), // Customize the border here
// ),
// keyboardType: TextInputType.text,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your email';
// }
// // You can add more complex email validation here if needed
// return null; // Return null if validation passes
// },
// ),
// const SizedBox(height: 18),
// TextFormField(
// controller: _phoneController,
// decoration: InputDecoration(
// hintText: "Phone",
// border: OutlineInputBorder(), // Customize the border here
// ),
// keyboardType: TextInputType.text,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter your phone number';
// }
// return null; // Return null if validation passes
// },
// ),
// const SizedBox(height: 18),
// TextFormField(
// controller: _passwordController,
// decoration: InputDecoration(
// hintText: "Password",
// border: OutlineInputBorder(), // Customize the border here
// ),
// keyboardType: TextInputType.text,
// obscureText: true,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please enter a password';
// }
// // You can add more complex password validation here if needed
// return null; // Return null if validation passes
// },
// ),
