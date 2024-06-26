import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/app_root.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/Gurdian_apiService.dart';
import '../core/utils/bubble_indication_painter.dart';
import '../widgets/custom_loader.dart';
import '../widgets/loading_dialog.dart';

class LoginPage extends StatefulWidget {
  //LoginPage({required Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController = PageController();

  Color left = Colors.black;
  Color right = Colors.white;

  int? gurdianId;
  String? profilePictureUrl;

  Future<void> _loginUser() async {
    //TODO: Put Login Credentials here
    // Mimi@gmail.com
    // Password: test123
    String email = loginEmailController.text.trim();
    String password = loginPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      // Show error message or handle empty fields
      return;
    }

    loadingDialog(context);
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Extract user data
      User? user = userCredential.user;
      if (user != null) {
        print('Login successful');
        print('User ID: ${user.uid}');
        print('Email: ${user.email}');

        // Retrieve guardian information from Firestore
        DocumentSnapshot guardianSnapshot = await FirebaseFirestore.instance
            .collection('guardians')
            .doc(user.uid)
            .get();

        if (guardianSnapshot.exists) {
          // Guardian data exists, print it
          Map<String, dynamic> guardianData =
              guardianSnapshot.data() as Map<String, dynamic>;
          print('Guardian Data:');
          print('gurdianMysqlId:::: ${guardianData['mysqlId']}');
          print('First Name: ${guardianData['fname']}');
          print('Last Name: ${guardianData['lname']}');
          print('Phone: ${guardianData['phone']}');
          // Print other guardian information as needed

          // Save guardian data to SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setInt('pref_id', guardianData['firestoreId']!);
          await prefs.setInt('pref_id', guardianData['mysqlId']);
          await prefs.setString('pref_fname', guardianData['fname']);
          await prefs.setString('pref_lname', guardianData['lname']);
          await prefs.setString('pref_email', guardianData['email']);
          await prefs.setString('pref_phone', guardianData['phone']);
          await prefs.setString('pref_role', guardianData['role']);
          await prefs.setString(
              'pref_profilepicture', guardianData['profilepicture']);
          await prefs.setString(
              'pref_digitalfingerprint', guardianData['digitalfingerprint']);

          // Print saved guardian data from SharedPreferences
          print('Saved Guardian Data:');
          //  print('ID: ${prefs.getInt('pref_id')}');
          print('First Name Prefference: ${prefs.getString('pref_fname')}');
          print('Last Name Prefference : ${prefs.getString('pref_lname')}');
          print('Email Prefference: ${prefs.getString('pref_email')}');
          print('Phone Prefference: ${prefs.getString('pref_phone')}');
          print('Role Prefference: ${prefs.getString('pref_role')}');
          print(
              'Profile Picture Prefference: ${prefs.getString('pref_profilepicture')}');
          print(
              'Digital Fingerprint Prefference: ${prefs.getString('pref_digitalfingerprint')}');

          // Navigate to the desired screen or perform other actions
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    //  noSummaryClass(),
                    const AppRoot(),
              ),
            );
          }
        } else {
          // Handle guardian data not found
          if (mounted) {
            Navigator.pop(context);
          }
          print('Guardian data not found for User ID: ${user.uid}');
        }
      } else {
        // Handle login failure
        if (mounted) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content:
                    const Text('Invalid email or password. Please try again.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }

        print('Login failed');
      }
    } catch (e) {
      // Handle login errors
      if (mounted) {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Error'),
              content: Text('Login error: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      print('Login error: $e');
    }
  }

  Future<void> fetchProfilePicture() async {
    try {
      String? url = await GardianApiService().getProfilePictureById(gurdianId!);
      setState(() {
        profilePictureUrl = url;
      });
    } catch (e) {
      print('Error loading profile picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            // overscroll.disallowGlow();
            overscroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height
              // >= 775.0
              // ? MediaQuery.of(context).size.height
              // : 775.0
              ,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      AppColors.linearTop,
                      AppColors.linearBottom,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Image.asset(
                        'assets/images/bus.png',
                        width: 250,
                        height: 230,
                        fit: BoxFit.fitWidth,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 1.0),
                    child: _buildMenuBar(context),
                  ),
                  Expanded(
                    flex: 2,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (i) {
                        if (i == 0) {
                          setState(() {
                            right = Colors.white;
                            left = Colors.black;
                          });
                        } else if (i == 1) {
                          setState(() {
                            right = Colors.black;
                            left = Colors.white;
                          });
                        }
                      },
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: const BoxConstraints.expand(),
                          child: _buildSignIn(context),
                        ),
                        // ConstrainedBox(
                        //   constraints: const BoxConstraints.expand(),
                        //   child: _buildSignUp(context),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
    fetchProfilePicture();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(FocusNode());
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }

  Widget _buildMenuBar(BuildContext context) {
    return Container(
      width: 300.0,
      height: 50.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
      ),
      child: CustomPaint(
        painter: TabIndicationPainter(pageController: _pageController),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  // highlightColor: Colors.transparent,
                ),
                onPressed: _onSignInButtonPress,
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: left,
                    // Change 'left' to 'Colors.blue' or the color you want
                    fontSize: 16.0,
                    fontFamily: "WorkSansSemiBold",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            //overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              FontAwesomeIcons.envelope,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: "Email Address",
                            hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                          ),
                        ),
                      ),
                      Container(
                        width: 250.0,
                        height: 1.0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: const TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: const Icon(
                              FontAwesomeIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                                fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
                              child: Icon(
                                _obscureTextLogin
                                    ? FontAwesomeIcons.eye
                                    : FontAwesomeIcons.eyeSlash,
                                size: 15.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 170.0),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.7),
                      offset: const Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: const LinearGradient(
                      colors: [
                        AppColors.linearTop,
                        AppColors.linearMiddle,
                        // AppColors.linearBottom,
                      ],
                      begin: FractionalOffset(0.2, 0.2),
                      end: FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: MaterialButton(
                  highlightColor: Colors.transparent,
                  splashColor: Theme.Colors.loginGradientEnd,
                  //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontFamily: "WorkSansBold"),
                    ),
                  ),

                  onPressed: () async {
                    _loginUser();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
