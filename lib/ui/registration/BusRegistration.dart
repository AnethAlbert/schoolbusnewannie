//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:icons_flutter/icons_flutter.dart';
// import 'package:schoolbassapp/componets/widgets/text_field_input.dart';
// import 'package:schoolbassapp/models/bus.dart';
// import 'package:schoolbassapp/ui/bucket/create_trip_page.dart';
// import 'package:schoolbassapp/style/theme.dart' as Theme;
// import 'package:schoolbassapp/ui/login_page.dart';
// import 'package:schoolbassapp/utils/utils.dart';
// import '../../services/Buss_apiService.dart';
//
// class BussRegistration extends StatefulWidget {
//   const BussRegistration({Key? key}) : super(key: key);
//
//   @override
//   State<BussRegistration> createState() =>
//       _BussRegistrationState();
// }
//
// class _BussRegistrationState extends State<BussRegistration> {
//   final TextEditingController _registration_number = TextEditingController();
//   final TextEditingController _model  = TextEditingController();
//   final TextEditingController _capacity = TextEditingController();
//
//   bool isLoading = false;
//   final ApiService _apiService = ApiService();
//
//   List <String> roles = ['Teacher','Head Teacher'];
//   String ? selectedIttem = 'Teacher';
//
//   @override
//   void dispose() {
//     super.dispose();
//     _registration_number.dispose();
//     _model.dispose();
//     _capacity.dispose();
//   }
//
//
//
//   singUpBus() async {
//     setState(() {
//       isLoading = true;
//     });
//
//     try {
//
//       // Use the correct method from ApiService
//       Bus bus = await _apiService.addBus(
//         _registration_number.text,
//         _model.text,
//         int.parse(_capacity.text),
//         context,
//       );
//
//       // Check if the response is successful
//       if (bus != null) {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
//       } else {
//         showSnackBar("Failed to sign up", context);
//       }
//     } catch (error) {
//       showSnackBar("Error occurred: $error", context);
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//
//
//   void navigatetologin() {
//     Navigator.of(context).push(MaterialPageRoute(
//       builder: (context) => noSummaryClass(),
//     ));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//           child: SingleChildScrollView(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   colors: [
//                     Theme.Colors.loginGradientStart,
//                     Theme.Colors.loginGradientEnd,
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: 32),
//               width: double.infinity,
//               height: 800,
//               child: SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     const SizedBox(height: 18),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Flexible(
//                           flex: 6,
//                           child: Container(
//                             // color: Colors.blue,
//                               child: Row(
//                                 children: [
//                                   CircleAvatar(
//                                     radius: 30,
//                                     backgroundImage: NetworkImage(
//                                         'https://png.pngtree.com/png-vector/20211011/ourmid/pngtree-school-logo-png-image_3977360.png'), // You can replace this with the URL of your avatar image
//                                   ),
//                                   SizedBox(width: 16.0),
//                                   // Adjust the spacing between the avatar and the username
//                                   Text(
//                                     'Keifo Primary School',
//                                     style: TextStyle(
//                                         fontSize: 18.0,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               )),
//                         ),
//                         Flexible(
//                           flex: 2,
//                           child: Container(
//                             //color: Colors.grey,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Icon(Ionicons.ios_alert,),
//                                 )
//                               ],
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//
//                     const SizedBox(height: 50),
//                     Text("Bus Registration"),
//                     const SizedBox(height: 20),
//
//                     const SizedBox(height: 18),
//                     TextFieldInput(
//                         textEditingController: _registration_number,
//                         hintText: "registration Number",
//                         textInputType: TextInputType.visiblePassword,
//                         onTap: (){print("first name is tapped");}, validator: (value) {  },
//                     ),
//                     const SizedBox(height: 18),
//                     TextFieldInput(
//                       textEditingController: _model,
//                       hintText: "model",
//                       textInputType: TextInputType.visiblePassword, validator: (value) {  },
//                     ),
//                     const SizedBox(height: 18),
//                     TextFieldInput(
//                       textEditingController: _capacity,
//                       hintText: "capacity",
//                       textInputType: TextInputType.visiblePassword, validator: (value) {  },
//                     ),
//                     const SizedBox(height: 18),
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 8.0),
//                       child: isLoading
//                           ?  Container(
//                         child: Center(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text("Waiting "),
//                               SizedBox(width: 2),
//                               SpinKitWave(color: Colors.white, size: 30),
//                               // Add more widgets if needed
//                             ],
//                           ),
//                         ),
//                       )
//                           : Container(
//                         //margin: EdgeInsets.only(top: 10.0),
//                         decoration: new BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                           boxShadow: <BoxShadow>[
//                             BoxShadow(
//                               color: Theme.Colors.loginGradientStart,
//                               offset: Offset(1.0, 6.0),
//                               blurRadius: 20.0,
//                             ),
//                             BoxShadow(
//                               color: Theme.Colors.loginGradientEnd,
//                               offset: Offset(1.0, 6.0),
//                               blurRadius: 20.0,
//                             ),
//                           ],
//                           gradient: new LinearGradient(
//                               colors: [
//                                 Theme.Colors.loginGradientEnd,
//                                 Theme.Colors.loginGradientStart
//                               ],
//                               begin: const FractionalOffset(0.2, 0.2),
//                               end: const FractionalOffset(1.0, 1.0),
//                               stops: [0.0, 1.0],
//                               tileMode: TileMode.clamp),
//                         ),
//                         child: MaterialButton(
//                             highlightColor: Colors.transparent,
//                             splashColor: Theme.Colors.loginGradientEnd,
//                             //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
//                             child: Padding(
//                               padding: const EdgeInsets.symmetric(
//                                   vertical: 10.0, horizontal: 42.0),
//                               child: Text(
//                                 "SIGN UP",
//                                 style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 25.0,
//                                     fontFamily: "WorkSansBold"),
//                               ),
//                             ),
//                             onPressed: (){print("Enock");singUpBus();} ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//
//
//   }
//
//   void showDropdownMenu(BuildContext context) {
//     DropdownButton<String>(
//         value: selectedIttem,
//         items: roles.map((role) => DropdownMenuItem<String>(
//           value: role,
//           child: Text(role ,style: TextStyle(fontSize: 24)),
//
//         )).toList(),
//         onChanged: (role)=> setState(() {
//           selectedIttem = role;
//         })
//
//     );
//   }
//
// }

// /////////******************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:newschoolbusapp/core/utils/input_validation.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/trip_pages/create_trip_page.dart';
import 'package:newschoolbusapp/ui/guardian/registrationRoom.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';
import 'package:newschoolbusapp/widgets/custom_snackbar.dart';
import 'package:newschoolbusapp/widgets/loading_dialog.dart';
import '../../core/models/bus.dart';
import '../../core/services/Buss_apiService.dart';
import '../../core/utils/app_colors.dart';
import '../../core/utils/utils.dart';
import '../../presentation/componets/widgets/text_field_input.dart';

class BussRegistration extends StatefulWidget {
  const BussRegistration({Key? key}) : super(key: key);

  @override
  State<BussRegistration> createState() => _BussRegistrationState();
}

class _BussRegistrationState extends State<BussRegistration> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _registration_number = TextEditingController();
  final TextEditingController _model = TextEditingController();
  final TextEditingController _capacity = TextEditingController();

  bool isLoading = false;
  final ApiService _apiService = ApiService();

  List<String> roles = ['Teacher', 'Head Teacher'];
  String? selectedIttem = 'Teacher';

  @override
  void dispose() {
    super.dispose();
    _registration_number.dispose();
    _model.dispose();
    _capacity.dispose();
  }

  singUpBus() async {
    loadingDialog(context);
    try {
      // Use the correct method from ApiService
      if (!_formKey.currentState!.validate()) {
        throw Exception("Validation Error");
      }
      Bus bus = await _apiService.addBus(
        _registration_number.text,
        _model.text,
        int.parse(_capacity.text),
        context,
      );

      // Check if the response is successful
      if (bus != null) {
        if (mounted) {
          Navigator.pop(context);
          Navigator.pop(context);
          customSnackBar(context, "Success.", Colors.green);
        }
      } else {
        if (mounted) {
          Navigator.pop(context);
          customSnackBar(context, "Error: Failed to create Bus.", Colors.red);
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  "Bus Registration",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 18),
                TextFieldInput(
                    textEditingController: _registration_number,
                    hintText: "registration Number",
                    textInputType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Registration number is required.';
                      }
                      return null; // Return null if validation passes
                    },
                    onTap: () {}),
                const SizedBox(height: 18),
                TextFieldInput(
                  textEditingController: _model,
                  hintText: "model",
                  textInputType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bus model is required.';
                    }
                    return null; // Return null if validation passes
                  },
                ),
                const SizedBox(height: 18),
                TextFieldInput(
                  textEditingController: _capacity,
                  hintText: "capacity",
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Bus capacity is required.';
                    } else {
                      return InputValidation.numbers(value);
                    }
                  },
                ),
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
                          label: "Register Bus",
                          onPressed: () => singUpBus(),
                        ),
                ),
              ],
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
