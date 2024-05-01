import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:newschoolbusapp/ui/profiles/studentProfile2.dart';

import 'package:newschoolbusapp/utils/app_colors.dart';
import 'package:newschoolbusapp/widgets/MyclipPath.dart';
import 'package:newschoolbusapp/widgets/cupartinoButton.dart';
import 'package:newschoolbusapp/widgets/green_intro_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileStudent extends StatefulWidget {
  const MyProfileStudent({Key? key}) : super(key: key);

  @override
  State<MyProfileStudent> createState() => _MyProfileStudentState();
}

class _MyProfileStudentState extends State<MyProfileStudent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AuthController authController = Get.find<AuthController>();

  Future<Map<String, String>> getUserInfoFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
   // final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    final fname = prefs.getString('fname') ?? '';
    final lname = prefs.getString('lname') ?? '';
    final email = prefs.getString('email') ?? '';
    final phone = prefs.getString('phone') ?? '';
    final profilepicture = prefs.getString('profilepicture') ?? '';
    final digitalfingerprint = prefs.getString('digitalfingerprint') ?? '';


    return {
      'id': id,
      'fname': fname,
      'lname': lname,
      'email': email,
      'phone': phone,
      'profilepicture': profilepicture,
      'digitalfingerprint': digitalfingerprint,
    };
  }

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      selectedImage = File(image.path);
      setState(() {});
    }
  }

  late LatLng homeAddress;
  late LatLng businessAddress;
  late LatLng shoppingAddress;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
// Setting initial values
    nameController.text = "John Doe Kambanga";
    homeController.text = "enockdamas@gmail.com";
    businessController.text = "+2557946132";
    shopController.text = "student";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipPath(
                // clipper: MyClipper(),
                child: Container(
                  // height: Get.height * 0.4,
                  height: 210,
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
                  child: Stack(
                    children: [
                      //greenIntroWidgetWithoutLogos(title: 'My Profile'),
                      Align(
                        alignment: Alignment.topCenter,
                        child: FutureBuilder<Map<String, String>>(
                          future: getUserInfoFromSharedPreferences(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              String firstName = snapshot.data!['fname'] ?? 'Unknown';
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  firstName,
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          },
                        ),
                      ),

                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                            ),
                            InkWell(
                              onTap: () {
                                getImage(ImageSource.camera);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 120,
                                  height: 120,
                                  margin: EdgeInsets.only(bottom: 20),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.circle,
                                    color: Color(0xffD6D6D6),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.black12,
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            CupertinoIcons.printer_fill,
                                            size: 50,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            print("report");
                                            // Add your onPressed logic here
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("Report")
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.black12,
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            CupertinoIcons.folder_circle,
                                            size: 50,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            print("Attendacy");
                                            // Add your onPressed logic here
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("Attendacy")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.black12,
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            CupertinoIcons.house_fill,
                                            size: 50,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            print("Parent");
                                            // Add your onPressed logic here
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("Parent")
                            ],
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: 170,
                          width: 170,
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Container(
                                        height: 100,
                                        width: 100,
                                        color: Colors.black12,
                                        child: CupertinoButton(
                                          padding: EdgeInsets.zero,
                                          child: Icon(
                                            CupertinoIcons.profile_circled,
                                            size: 50,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => MyProfileStudent2(),
                                              ),
                                            );
                                            print("Profile");
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text("Profile")
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

TextFieldWidget(String title, IconData iconData,
    TextEditingController controller, Function validator,
    {Function? onTap, bool readOnly = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(
            fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
      ),
      const SizedBox(
        height: 6,
      ),
      Container(
        width: Get.width,
        // height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  spreadRadius: 1,
                  blurRadius: 1)
            ],
            borderRadius: BorderRadius.circular(8)),
        child: TextFormField(
          readOnly: readOnly,
          onTap: () => onTap!(),
          validator: (input) => validator(input),
          controller: controller,
          style: GoogleFonts.poppins(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          decoration: InputDecoration(
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                iconData,
                color: AppColors.greenColor,
              ),
            ),
            border: InputBorder.none,
          ),
        ),
      )
    ],
  );
}

Widget greenButton(String title, Function onPressed) {
  return MaterialButton(
    minWidth: Get.width,
    height: 50,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    color: AppColors.greenColor,
    onPressed: () => onPressed(),
    child: Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  );
}
