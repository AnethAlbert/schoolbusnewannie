//*******************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newschoolbusapp/core/utils/input_validation.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/ui/guardian/registrationRoom.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';
import '../../core/models/class.dart';
import '../../core/services/Class_apiService.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/utils.dart';
import '../../presentation/componets/widgets/text_field_input.dart';

class ClassRegistration extends StatefulWidget {
  const ClassRegistration({Key? key}) : super(key: key);

  @override
  State<ClassRegistration> createState() => _ClassRegistrationState();
}

class _ClassRegistrationState extends State<ClassRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _capacity = TextEditingController();

  bool isLoading = false;
  final ClassApiService _apiService = ClassApiService();

  List<String> roles = ['Teacher', 'Head Teacher'];
  String? selectedIttem = 'Teacher';

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
    _name.dispose();
    _capacity.dispose();
  }

  singUpClass() async {
    loadingDialog(context);

    try {
      // Use the correct method from ApiService
      Class clas = await _apiService.addClass(
        _code.text,
        _name.text,
        int.parse(_capacity.text),
        context,
      );

      // Check if the response is successful
      if (clas != null) {
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
          customSnackBar(context, "success", Colors.green);
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          customSnackBar(
              context, "Error occurred: Failed to register class", Colors.red);
        }
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);
        customSnackBar(context, "Error occurred: $error", Colors.red);
      }
    } finally {}
  }

  void navigatetologin() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StartTripPage(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
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
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                    'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
                              ),
                              SizedBox(width: 16.0),
                              // Adjust the spacing between the avatar and the username
                              Text(
                                'Keifo Primary School',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Class Registration",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _code,
                    hintText: "Code",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Code is required.';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _name,
                    hintText: "name",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required.';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  TextFieldInput(
                    textEditingController: _capacity,
                    hintText: "capacity",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Capacity is required.';
                      } else {
                        return InputValidation.numbers(value);
                      }
                    },
                  ),
                  const SizedBox(height: 18),
                  CustomMaterialButton(
                    label: "Register Class",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        singUpClass();
                      }
                    },
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
