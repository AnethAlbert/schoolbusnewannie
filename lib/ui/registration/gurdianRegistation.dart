import 'dart:convert';

// import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newschoolbusapp/core/utils/input_validation.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/dropDownButton.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';

import '../../core/models/fireBaseModels/gurdisanfb.dart';
import '../../core/models/gurdian.dart';
import '../../core/services/Gurdian_apiService.dart';
import '../../core/services/firebaseservices/fingerprint_id_service.dart';
import '../../core/services/firebaseservices/gurdian_database_service.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/image_utils.dart';
import '../../core/utils/utils.dart';
import '../../presentation/componets/widgets/text_field_input.dart';

class GuardianRegistrationClass extends StatefulWidget {
  const GuardianRegistrationClass({super.key});

  @override
  State<GuardianRegistrationClass> createState() =>
      _GuardianRegistrationClassState();
}

class _GuardianRegistrationClassState extends State<GuardianRegistrationClass> {
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
  final FingerprintIdService fingerprintIdService = FingerprintIdService();

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
    getNewFingerprintId(); // Generate unique number when page is loaded
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

  // Function to get a unique number between 1 and 127
  Future<void> getNewFingerprintId() async {
    // _uniqueNumber = (Random().nextInt(127) + 1).toString();
    // _digitalFingerPrintController.text = '$_uniqueNumber';
    String? id = await fingerprintIdService.getNewFingerprintId();
    if (id != null) {
      if (int.parse(id) >= 127) {
        if (mounted) {
          showSnackBar("Fingerprint device storage is full", context);
        }
        return;
      }
      _digitalFingerPrintController.text = id;
      _uniqueNumber = id;
    }
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
    loadingDialog(context);

    try {
      // Ensure _image is not null
      if (_image == null) {
        throw Exception("Image is required.");
      }

      // Convert _image to base64-encoded string
      String base64Image = await ImageUtils.compressImage(_image!);

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

      if (!mounted) {
        return;
      }
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

      if (kDebugMode) {
        print("GUARD PROFILE: Added to MySql");
      }

      // Retrieve the ID of the saved Guardian
      int mysqlId = savedGuardian.id!;

      // Register user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: guardian.email!, password: guardian.password!);

      if (kDebugMode) {
        print("GUARD PROFILE: Added Auth User");
      }

      // Get the Firebase User ID
      String firebaseUserId = userCredential.user!.uid;

      // Create a GuardianFB object for Firebase
      GurdianFB guardianFB = GurdianFB(
        firebaseId: firebaseUserId,
        firestoreId: null,
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

      GurdianFB _guardianFB = GurdianFB(
        firebaseId: firebaseUserId,
        firestoreId: null,
        mysqlId: mysqlId,
        fname: guardian.fname!,
        lname: guardian.lname!,
        email: guardian.email!,
        phone: guardian.phone!,
        digitalfingerprint: guardian.digitalfingerprint!,
        role: guardian.role!,
        timestamp: guardian.timestamp!,
      );

      if (kDebugMode) {
        print(_guardianFB.toJson());
      }

      // Insert the GuardianFB object into Firestore with user.uid as document ID
      await FirebaseFirestore.instance
          .collection('guardians')
          .doc(firebaseUserId) // Use user.uid as the document ID
          .set(guardianFB.toJson());

      if (kDebugMode) {
        print("GUARD PROFILE: Added to Firestore");
      }

      await fingerprintIdService.updateFingerprintId();

      if (kDebugMode) {
        print("GUARD PROFILE: Added new FingerprintId");
      }

      // Proceed with navigation or any other actions
      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        customSnackBar(context, "Success", Colors.green);
      }
    } catch (error) {
      // Print the error to the console
      if (mounted) {
        Navigator.pop(context);
        customSnackBar(context, "Error occurred: $error", Colors.red);
      }
      if (kDebugMode) {
        print("Error occurred during sign up: $error");
      }
      // Show error in SnackBar
    } finally {}
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.linearTop,
                  AppColors.linearBottom,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Guardian Registration",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                            icon: const Icon(
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
                          return 'Please enter your first name.';
                        }
                        return null; // Return null if validation passes
                      },
                      onTap: () {}),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _lastNameController,
                    hintText: "last name",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name.';
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
                        return 'Please enter your email.';
                      } else {
                        return InputValidation.email(value);
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _phoneController,
                    hintText: "phone",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number.';
                      } else {
                        return InputValidation.phone(value);
                      } // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  // TextFieldInput(
                  //   textEditingController: _digitalFingerPrintController,
                  //   hintText: "digital Finger print",
                  //   textInputType: TextInputType.text,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your first name';
                  //     }
                  //     return null; // Return null if validation passes
                  //   },
                  //   readOnly: true,
                  //   onTap: () {
                  //     // generateUniqueNumber(); // Generate unique number
                  //     // Show a dialog box when the text field is tapped
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: const Text("Add Digital Fingerprint"),
                  //           content: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Text("Unique Number: $_uniqueNumber"),
                  //               // Display the unique number
                  //               const SizedBox(height: 10),
                  //               const Text("Add Signature"),
                  //               const SizedBox(height: 10),
                  //               SizedBox(
                  //                 height: 50,
                  //                 width: 50,
                  //                 child: Image.network(
                  //                   'https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ionicons_finger-print-sharp.svg/640px-Ionicons_finger-print-sharp.svg.png',
                  //                   fit: BoxFit.cover,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           actions: [
                  //             TextButton(
                  //               onPressed: () {
                  //                 Navigator.pop(context);
                  //               },
                  //               child: const Text("Cancel"),
                  //             ),
                  //             TextButton(
                  //               onPressed: () {
                  //                 _apiService
                  //                     .addFingerPrint(_uniqueNumber)
                  //                     .then((response) {
                  //                   // Handle success
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                       content: Text(response['message']),
                  //                       backgroundColor: Colors
                  //                           .green, // Show success message in green
                  //                     ),
                  //                   );
                  //                 }).catchError((error) {
                  //                   // Handle error
                  //                   ScaffoldMessenger.of(context).showSnackBar(
                  //                     SnackBar(
                  //                       content: Text(error.toString()),
                  //                       backgroundColor: Colors
                  //                           .red, // Show error message in red
                  //                     ),
                  //                   );
                  //                 }).whenComplete(() {
                  //                   // Close the dialog box
                  //                   Navigator.pop(context);
                  //                 });
                  //               },
                  //               child: const Text("OK"),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 18),
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
                  TextFieldInput(
                    textEditingController: _passwordController,
                    hintText: "password",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      } else {
                        return InputValidation.minLength(value, 6);
                      }
                    },
                  ),
                  const SizedBox(height: 18),

                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: DropDownButton(
                      items: roles,
                      selectedValue: selectedRole,
                      onChanged: (value) {
                        setState(() {
                          selectedRole = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 18),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: CustomMaterialButton(
                      label: "Register Guardian",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // signUpUser();
                          if (_image == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Image is required."),
                                backgroundColor:
                                    Colors.red, // Show success message in green
                              ),
                            );
                            return;
                          }
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              bool waitFingerPrintCapture = true;

                              _apiService
                                  .addFingerPrint(_uniqueNumber)
                                  .then((response) {
                                // Handle success
                                waitFingerPrintCapture = false;

                                customSnackBar(
                                  context,
                                  response["message"],
                                  Colors.green,
                                );
                              }).catchError((error) {
                                customSnackBar(
                                  context,
                                  error.toString(),
                                  Colors.red,
                                );
                              });

                              return AlertDialog(
                                title: const Text("Add Digital Fingerprint"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text(
                                        "Press your Finger for two (2) seconds, twice to capture new fingerprint."),
                                    const SizedBox(height: 20),
                                    SizedBox(
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
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      !waitFingerPrintCapture
                                          ? signUpUser()
                                          : null;
                                    },
                                    child: const Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          customSnackBar(
                            context,
                            "Failed. Validation Error",
                            Colors.red,
                          );
                        }
                      },
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
