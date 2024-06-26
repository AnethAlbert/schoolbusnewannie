import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

//import 'dart:html' as html;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/core/utils/input_validation.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/ui/guardian/registrationRoom.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/dropDownButton.dart';

import '../../core/models/class.dart';
import '../../core/models/fireBaseModels/studentfb.dart';
import '../../core/models/station.dart';
import '../../core/models/student.dart';
import '../../core/services/Class_apiService.dart';
import '../../core/services/Station_apiService.dart';
import '../../core/services/Student_apiService.dart';
import '../../core/services/firebaseservices/fingerprint_id_service.dart';
import '../../core/services/firebaseservices/student_database_service.dart';
import '../../core/utils/image_utils.dart';
import '../../core/utils/utils.dart';
import '../../presentation/componets/widgets/text_field_input.dart';
import '../../widgets/loading_dialog.dart';

class StudentRegistrationClass extends StatefulWidget {
  const StudentRegistrationClass({Key? key}) : super(key: key);

  @override
  State<StudentRegistrationClass> createState() =>
      _StudentRegistrationClassState();
}

class _StudentRegistrationClassState extends State<StudentRegistrationClass> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _registration_numberController =
      TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _class_idController = TextEditingController();
  final TextEditingController _station_idController = TextEditingController();
  final TextEditingController _digitalFingerPrintController =
      TextEditingController();
  final TextEditingController _profilepictureController =
      TextEditingController();

  String _uniqueNumber = '';
  final FingerprintIdService fingerprintIdService = FingerprintIdService();

  // Fetch a Unique fingerprint ID
  Future<void> getNewFingerprintId() async {
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

  Uint8List? _image;
  bool isLoading = false;
  final StudentApiService _apiService = StudentApiService();
  final ClassApiService _classsapiService = ClassApiService();
  final StationApiService _stationapiService = StationApiService();
  final StudentDatabaseService _databaseService = StudentDatabaseService();

  List<Map<String, dynamic>> classes = [];
  String? selectedIttem;

  List<Map<String, dynamic>> stations = [];
  String? selectedStation;

  int? classId;
  int? stationId;
  String? imagedata;

  // var image;
  XFile? _pickedImage;

  @override
  void initState() {
    super.initState();
    // Fetch classes when the widget initializes
    fetchClasses();
    fetchStation();
    getNewFingerprintId();
  }

  Future<void> fetchClasses() async {
    try {
      List<Class> fetchedClasses = await ClassApiService().getAllClasses();
      setState(() {
        classes = fetchedClasses
            .map((classValue) => {
                  'id': classValue.id,
                  'name': classValue.name ?? '',
                })
            .toList();
        selectedIttem = classes.isNotEmpty ? classes.first['name'] : null;
      });
    } catch (error) {
      print('Error fetching classes: $error');
      // Handle error as needed
    }
  }

  Future<void> fetchStation() async {
    try {
      List<Station> fetchedStations =
          await StationApiService().getAllStations();
      setState(() {
        stations = fetchedStations
            .map((stationValue) => {
                  'id': stationValue.id,
                  'name': stationValue.name ?? '',
                })
            .toList();
        selectedStation = stations.isNotEmpty ? stations.first['name'] : null;
      });
    } catch (error) {
      print('Error fetching stations: $error');
      // Handle error as needed
    }
  }

  @override
  void dispose() {
    super.dispose();
    _class_idController.dispose();
    _station_idController.dispose();
    _registration_numberController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    _profilepictureController.dispose();
    _digitalFingerPrintController.dispose();
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
  void signUpUser() async {
    loadingDialog(context);

    try {
      // Ensure _image is not null
      if (_image == null) {
        throw Exception("Image is required.");
      }

      // Convert _image to base64-encoded string
      String base64Image = await ImageUtils.compressImage(_image!);

      // Create a Student object
      Student student = Student(
        fname: _firstNameController.text,
        lname: _lastNameController.text,
        class_id: classId,
        station_id: stationId,
        registration_number: _registration_numberController.text,
        age: int.parse(_ageController.text),
        profilepicture: base64Image,
        digitalfingerprint: _digitalFingerPrintController.text,
        timestamp: DateTime.now(),
      );

      // Add the Student to MySQL using ApiService
      Student savedStudent = await _apiService.addStudent(
        fname: student.fname!,
        lname: student.lname!,
        classId: student.class_id!,
        stationId: student.station_id!,
        registrationNumber: student.registration_number!,
        age: student.age!,
        profilePicture: student.profilepicture!,
        digitalFingerprint: student.digitalfingerprint!,
        context: context,
      );

      // Retrieve the ID of the saved Student from MySQL
      int mysqlId = savedStudent.id!;

      // Create a StudentFB object for Firebase
      StudentFB studentFB = StudentFB(
        mysqlId: mysqlId,
        fname: student.fname!,
        lname: student.lname!,
        class_id: student.class_id!,
        station_id: student.station_id!,
        registration_number: student.registration_number!,
        age: student.age!,
        profilepicture: base64Image,
        digitalfingerprint: student.digitalfingerprint!,
        timestamp: DateTime.now(),
      );

      // Add the StudentFB to Firestore
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection('students')
          .add(studentFB.toJson());

      // Update the firebaseId in StudentFB object with the generated document ID
      studentFB = studentFB.copyWith(fireaseId: docRef.id);

      // Update the document in Firestore with the firebaseId
      await docRef.update({'firebaseId': docRef.id});

      await fingerprintIdService.updateFingerprintId();
      if (kDebugMode) {
        print("STUDENT PROFILE: Added new FingerprintId");
      }

      if (mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        customSnackBar(context, "Success", Colors.green);
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);
        customSnackBar(
          context,
          "Error occurred: $error",
          Colors.red,
        );
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void navigatetologin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StartTripPage(),
    ));
  }

  ///********************fetch classes*****************
  Future<List<Map<String, dynamic>>> fetchClassesFromDatabase() async {
    try {
      // Call the API service method to get all classes
      List<Class> classList = await ClassApiService().getAllClasses();

      // Extract class names and IDs from the fetched data
      List<Map<String, dynamic>> classes = classList.map((classValue) {
        return {
          'id': classValue.id,
          // Assuming the class ID is stored in a property named 'id'
          'name': classValue.name ?? '',
        };
      }).toList();

      return classes;
    } catch (error) {
      print('Error fetching classes: $error');
      throw Exception('Error occurred while fetching classes');
    }
  }

  ///****************************************************

  ///********************fetch station*****************
  Future<List<Map<String, dynamic>>> fetchStationFromDatabase() async {
    try {
      List<Station> stationList = await StationApiService().getAllStations();
      List<Map<String, dynamic>> stationsData = stationList.map((station) {
        return {
          'id': station.id,
          'name': station.name ?? '',
        };
      }).toList();
      return stationsData;
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching stations: $error');
      }
      throw Exception('Error occurred while fetching stations');
    }
  }

  ///****************************************************

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
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Student Registration",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 20),
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
                          return 'Please enter student first name';
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
                        return 'Please enter student first name';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  // TextFieldInput(
                  //     textEditingController:_class_idController ,
                  //     hintText: "class",
                  //     textInputType: TextInputType.visiblePassword,
                  //     // readOnly: true,
                  //     onTap: (){print("digital Finger print is tapped");}
                  // ),

                  DropDownButton(
                    items: classes
                        .map((classMap) => classMap['name'].toString())
                        .toList(),
                    selectedValue: selectedIttem,
                    onChanged: (value) {
                      setState(() {
                        selectedIttem = value;
                        // Find the map corresponding to the selected class name
                        Map<String, dynamic> selectedClassMap =
                            classes.firstWhere(
                                (classMap) => classMap['name'] == value);
                        // Get the ID of the selected class
                        classId = selectedClassMap['id'];
                      });
                    },
                  ),

                  const SizedBox(height: 18),
                  // TextFieldInput(
                  //     textEditingController: _station_idController,
                  //     hintText: "station",
                  //     textInputType: TextInputType.visiblePassword,
                  //     // readOnly: true,
                  //     onTap: (){
                  //       showDropdownMenu(context);
                  //     }
                  // ),

                  DropDownButton(
                    items: stations
                        .map((stationMap) => stationMap['name'].toString())
                        .toList(),
                    selectedValue: selectedStation,
                    onChanged: (value) {
                      setState(() {
                        selectedStation = value;
                        // Find the map corresponding to the selected station name
                        Map<String, dynamic> selectedStationMap =
                            stations.firstWhere(
                                (stationMap) => stationMap['name'] == value);
                        // Get the ID of the selected station
                        stationId = selectedStationMap['id'];
                      });
                    },
                  ),

                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _registration_numberController,
                    hintText: "Registration number",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter student registration number';
                      }
                      return null; // Return null if validation passes
                    },
                  ),

                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _ageController,
                    hintText: "age",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter student age';
                      } else {
                        return InputValidation.numbers(value);
                      }
                    },
                  ),

                  // const SizedBox(height: 18),
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
                  //     getNewFingerprintId(); // Generate unique number
                  //     // Show a dialog box when the text field is tapped
                  //     showDialog(
                  //       context: context,
                  //       builder: (BuildContext context) {
                  //         return AlertDialog(
                  //           title: Text("Add Digital Fingerprint"),
                  //           content: Column(
                  //             mainAxisSize: MainAxisSize.min,
                  //             children: [
                  //               Text("Unique Number: $_uniqueNumber"),
                  //               // Display the unique number
                  //               SizedBox(height: 20),
                  //               Text("Add Signature"),
                  //               Container(
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
                  //               child: Text("Cancel"),
                  //             ),
                  //             TextButton(
                  //               onPressed: () {
                  //                 _apiService
                  //                     .addFingerPrint(_uniqueNumber!)
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
                  //               child: Text("OK"),
                  //             ),
                  //           ],
                  //         );
                  //       },
                  //     );
                  //   },
                  // ),
                  // TextFieldInput(
                  //   textEditingController: _digitalFingerPrintController,
                  //   hintText: "digital finger print",
                  //   textInputType: TextInputType.visiblePassword,
                  //  // ispass: true,
                  // ),
                  const SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: isLoading
                        ? const Center(
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
                          )
                        : CustomMaterialButton(
                            label: "Register Student",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                // signUpUser();
                                if (_image == null) {
                                  customSnackBar(
                                    context,
                                    "Image is required.",
                                    Colors.red,
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
                                      title:
                                          const Text("Add Digital Fingerprint"),
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
