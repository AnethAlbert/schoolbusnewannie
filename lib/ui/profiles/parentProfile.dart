import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:newschoolbusapp/utils/app_colors.dart';
import 'package:newschoolbusapp/widgets/MyclipPath.dart';
import 'package:newschoolbusapp/widgets/cupartinoButton.dart';
import 'package:newschoolbusapp/widgets/green_intro_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class MyProfileParent extends StatefulWidget {
  const MyProfileParent({Key? key}) : super(key: key);

  @override
  State<MyProfileParent> createState() => _MyProfileParentState();
}

class _MyProfileParentState extends State<MyProfileParent> {
  TextEditingController nameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController businessController = TextEditingController();
  TextEditingController shopController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // AuthController authController = Get.find<AuthController>();

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
    shopController.text = "Parent";
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("My Profile"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            SizedBox(height: 50,),
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
              Container(
                padding: EdgeInsets.symmetric(horizontal: 23),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFieldWidget(
                        'Name',
                        Icons.person_outlined,
                        nameController,
                            (String? input) {
                          if (input!.isEmpty) {
                            return 'Name is required!';
                          }
                          if (input.length < 5) {
                            return 'Please enter a valid name!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        'Email',
                        Icons.home_outlined,
                        homeController,
                            (String? input) {
                          if (input!.isEmpty) {
                            return 'Home Address is required!';
                          }
                          return null;
                        },
                        onTap: () async {
                          print("testing Profile 2");
                        },
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        'phone +',
                        Icons.card_travel,
                        businessController,
                            (String? input) {
                          if (input!.isEmpty) {
                            return 'Business Address is required!';
                          }
                          return null;
                        },
                        onTap: () async {
                          print('tesing Profile 3');
                        },
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFieldWidget(
                        'role',
                        Icons.account_circle_outlined,
                        shopController,
                            (String? input) {
                          if (input!.isEmpty) {
                            return 'Shopping Center is required!';
                          }
                          return null;
                        },
                        onTap: () async {
                          print("testing Profile 4");
                        },
                        readOnly: true,
                      ),
                      const SizedBox(
                        height: 10,
                      ),Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFFFEB3B), // Set the desired color here
                          borderRadius: BorderRadius.circular(8), // Adjust the border radius as needed
                        ),
                        child: CupertinoButton(
                          child: Text("Cancel",style: TextStyle(
                              color: Colors.black
                          ),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
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
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.white),
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
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black),
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
