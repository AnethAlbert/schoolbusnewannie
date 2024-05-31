import 'dart:convert';
//import 'dart:html';
//import 'dart:html' as html;
import 'dart:math';
// import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newschoolbusapp/componets/utils/colors.dart';
import 'package:newschoolbusapp/componets/widgets/text_field_input.dart';
import 'package:newschoolbusapp/models/fireBaseModels/gurdisanfb.dart';
import 'package:newschoolbusapp/models/gurdian.dart';
import 'package:newschoolbusapp/services/firebaseservices/gurdian_database_service.dart';
import 'package:newschoolbusapp/ui/bucket/bucketnew.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/gurdian/registrationRoom.dart';
import 'package:newschoolbusapp/ui/login_page.dart';
import 'package:newschoolbusapp/utils/utils.dart';
import 'package:mirai_dropdown_menu/mirai_dropdown_menu.dart';
import 'package:newschoolbusapp/widgets/dropDownButton.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

import '../../services/Gurdian_apiService.dart';

class GurdianRegistrationClass extends StatefulWidget {
  const GurdianRegistrationClass({Key? key}) : super(key: key);

  @override
  State<GurdianRegistrationClass> createState() =>
      _GurdianRegistrationClassState();
}

class _GurdianRegistrationClassState extends State<GurdianRegistrationClass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _profilePictureController =
      TextEditingController();
  final TextEditingController _digitalFingerPrintController =
      TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Uint8List? _image;
  String? filepath;
  String? imagedata;

  // var image;
  XFile? _pickedImage;
  bool isLoading = false;
  final GardianApiService _apiService = GardianApiService();
  final GurdianDatabaseService _databaseService = GurdianDatabaseService();

  List<String> roles = ['Teacher', 'Head Teacher'];
  String? selectedRole = 'Teacher';

  String _uniqueNumber = '';

  @override
  void initState() {
    super.initState();
    generateUniqueNumber(); // Generate unique number when page is loaded
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _profilePictureController.dispose();
    _digitalFingerPrintController.dispose();
    _roleController.dispose();
    _passwordController.dispose();
  }

  // Function to generate a unique number between 1 and 127
  void generateUniqueNumber() {
    setState(() {
      _uniqueNumber = (Random().nextInt(127) + 1).toString();
      // Set the generated number in the controller text
      _digitalFingerPrintController.text = '$_uniqueNumber';
    });
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
  //
  //   if (_pickedImage != null) {
  //     html.Blob blob = await html.window.fetch(_pickedImage!.path!).then((response) => response.blob());
  //     html.File file = html.File([blob], _pickedImage!.name); // Convert Blob to File
  //
  //     // Now you have the 'file' object which you can use
  //     print('File name: ${file.name}');
  //     print('File size: ${file.size} bytes');
  //     print('File type: ${file.type}');
  //
  //     final imageBytes = await _pickedImage!.readAsBytes();
  //    //  print("Image selected. Size: ${imageBytes}");
  //
  //     setState(() {
  //       _image = imageBytes;
  //     });
  //   } else {
  //     print("Image selection canceled.");
  //   }
  // }

  // void selectImageWeb() async {
  //   final FileUploadInputElement input = FileUploadInputElement();
  //   input.accept = 'image/*';
  //   input.click();
  //
  //   input.onChange.listen((event) {
  //     final List<File>? files = input.files;
  //
  //     if (files != null && files.isNotEmpty) {
  //       final File file = files.first;
  //       final String fileName = file.name;
  //       final String filePath = 'C:/Users/CO2/Documents/pssbRefaries/$fileName'; // Or any other path you want
  //       print('filepath on web: $filePath');
  //       filepath = filePath;
  //     }
  //   });
  // }

  Future<void> signUpUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Ensure _image is not null
      if (_image == null) {
        throw Exception("Image is required.");
      }

      // Convert _image to base64-encoded string
      String base64Image = base64Encode(_image!);

      // Create a Guardian object
      Gurdian guardian = Gurdian(
        fname: _firstNameController.text,
        lname: _lastNameController.text,
        email: _emailController.text,
        phone: _phoneController.text,
        profilepicture: base64Image,
        digitalfingerprint: _digitalFingerPrintController.text,
        role: selectedRole!,
        password: _passwordController.text,
        timestamp: DateTime.now(),
      );

      // Add the Guardian to MySQL using ApiService
      Gurdian savedGuardian = await _apiService.addGurdian(
        fname: guardian.fname!,
        lname: guardian.lname!,
        email: guardian.email!,
        phone: guardian.phone!,
        profilePicture: guardian.profilepicture!,
        digitalFingerprint: guardian.digitalfingerprint!,
        role: guardian.role!,
        password: guardian.password!,
        context: context,
      );

      // Retrieve the ID of the saved Guardian
      int mysqlId = savedGuardian.id!;

      // Register user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: guardian.email!, password: guardian.password!);

      // Get the Firebase User ID
      String firebaseUserId = userCredential.user!.uid;

      // Create a GuardianFB object for Firebase
      GurdianFB guardianFB = GurdianFB(
        firebaseId: firebaseUserId,
        mysqlId: mysqlId,
        fname: guardian.fname!,
        lname: guardian.lname!,
        email: guardian.email!,
        phone: guardian.phone!,
        profilepicture: guardian.profilepicture!,
        digitalfingerprint: guardian.digitalfingerprint!,
        role: guardian.role!,
        timestamp: guardian.timestamp!,
      );

      // Insert the GuardianFB object into Firestore with user.uid as document ID
      await FirebaseFirestore.instance
          .collection('guardians')
          .doc(firebaseUserId) // Use user.uid as the document ID
          .set(guardianFB.toJson());

      // Proceed with navigation or any other actions
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => registrationRoom()));
    } catch (error) {
      // Print the error to the console
      print("Error occurred during sign up: $error");
      // Show error in SnackBar
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
                  Center(child: Text("Gurdian Registration")),
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
                            onPressed:(){
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
                textEditingController: _digitalFingerPrintController,
                hintText: "digital Finger print",
                textInputType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null; // Return null if validation passes
                },
                readOnly: true,
                onTap: () {
                  // generateUniqueNumber(); // Generate unique number
                  // Show a dialog box when the text field is tapped
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Add Digital Fingerprint"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Unique Number: $_uniqueNumber"), // Display the unique number
                            SizedBox(height: 20),
                            Text("Add Signature"),
                            Container(
                              height: 50,
                              width: 50,
                              child: Image.network(
                                'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ionicons_finger-print-sharp.svg/640px-Ionicons_finger-print-sharp.svg.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              _apiService.addFingerPrint(_uniqueNumber!).then((response) {
                                // Handle success
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(response['message']),
                                    backgroundColor: Colors.green, // Show success message in green
                                  ),
                                );
                              }).catchError((error) {
                                // Handle error
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(error.toString()),
                                    backgroundColor: Colors.red, // Show error message in red
                                  ),
                                );
                              }).whenComplete(() {
                                // Close the dialog box
                                Navigator.pop(context);
                              });
                            },
                            child: Text("OK"),
                          ),

                        ],
                      );
                    },
                  );
                },
              ),


                  const SizedBox(height: 18),

                  //  TextFieldInput(
                  //   textEditingController: _roleController,
                  //     hintText: "role Textfield",
                  //   textInputType: TextInputType.visiblePassword,
                  //   readOnly: true,
                  //   onTap: (){
                  //    showDropdownMenu(context);
                  //   }
                  //
                  // ),

                  DropDownButton(
                    items: roles,
                    selectedValue: selectedRole,
                    onChanged: (value) {
                      setState(() {
                        selectedRole = value;
                      });
                    },
                  ),

                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "password",
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
                                    signUpUser();
                                  }
                                }),
                          ),
                  ),
                  // InkWell(
                  //   onTap: () {
                  //     print("ENockDamas");
                  //   },
                  //   child: isLoading
                  //       ? Center(child: CircularProgressIndicator())
                  //       : Container(
                  //           child: const Text("Sign Up"),
                  //           width: double.infinity,
                  //           alignment: Alignment.center,
                  //           padding: const EdgeInsets.symmetric(vertical: 15),
                  //           decoration: ShapeDecoration(
                  //               color: blueColor,
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(4))),
                  //         ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
