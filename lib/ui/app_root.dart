import 'package:flutter/material.dart';
import 'package:newschoolbusapp/ui/profiles/guedianProfile.dart';

import '../widgets/ParentSeachAutocomplete.dart';
import '../widgets/bottomNavigationClass.dart';
import 'guardian/registrationRoom.dart';
import 'live/mapPage.dart';

class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> viewItems = <Widget>[
    const RegistrationRoom(),
    const MapPage(),
    const autocomplete(),
    const MyProfileGuardian(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: viewItems[_selectedIndex],
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
