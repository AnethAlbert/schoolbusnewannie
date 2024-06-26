//***************************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/login_page.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';
import '../../core/models/route.dart';
import '../../core/services/Route_apiService.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/utils.dart';
import '../../presentation/componets/widgets/text_field_input.dart';

class RouteRegistration extends StatefulWidget {
  const RouteRegistration({Key? key}) : super(key: key);

  @override
  State<RouteRegistration> createState() => _RouteRegistrationState();
}

class _RouteRegistrationState extends State<RouteRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _name = TextEditingController();

  bool isLoading = false;
  final RouteApiService _apiService = RouteApiService();

  List<String> roles = ['Teacher', 'Head Teacher'];
  String? selectedIttem = 'Teacher';

  @override
  void dispose() {
    super.dispose();
    _code.dispose();
    _name.dispose();
  }

  singUpRoute() async {
    loadingDialog(context);

    try {
      // Use the correct method from ApiService
      RouteClass route = await _apiService.addRoute(
        _code.text,
        _name.text,
        context,
      );

      // Check if the response is successful
      if (route != null) {
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
          customSnackBar(context, "Success", Colors.green);
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          customSnackBar(
              context, "Error occurred: Failed to register route.", Colors.red);
        }
      }
    } catch (error) {
      if (mounted) {
        Navigator.pop(context);
        customSnackBar(context, "Error occurred: $error", Colors.red);
      }
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            height: MediaQuery.of(context).size.height,
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
                  const SizedBox(height: 18),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 6,
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
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const Text(
                    "Route Registration",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFieldInput(
                    textEditingController: _code,
                    hintText: "Inter Code",
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
                    hintText: "Inter name",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required.';
                      }
                      return null; // Return null if validation passes
                    },
                  ),
                  const SizedBox(height: 18),
                  CustomMaterialButton(
                    label: "Register Route",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        singUpRoute();
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

//
//
//
//
//
//
//
//
//
