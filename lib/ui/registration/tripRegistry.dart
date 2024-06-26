import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;
import 'package:newschoolbusapp/ui/registration/BusRegistration.dart';
import 'package:newschoolbusapp/ui/registration/ClassesRegistration.dart';
import 'package:newschoolbusapp/ui/registration/RouteRegistration.dart';
import 'package:newschoolbusapp/ui/registration/StationRegistration.dart';
import 'package:newschoolbusapp/widgets/custom_material_button.dart';

class TripRegistry extends StatefulWidget {
  const TripRegistry({Key? key}) : super(key: key);

  @override
  State<TripRegistry> createState() => _TripRegistryState();
}

class _TripRegistryState extends State<TripRegistry> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: ListView(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, left: 50.0, right: 50.0, bottom: 20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Colors.white,
                      width: double.infinity,
                      height: 30,
                      child: Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text("Trip Registry"),
                        ),
                      ),
                    ),
                  )),

              ///*****************************parent,student****************

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 16.0, right: 16, top: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomMaterialButton(
                            label: "Bus",
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const BussRegistration(),
                                ),
                              );
                            },
                          ),
                          CustomMaterialButton(
                              label: "Station",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const StationRegistration(),
                                  ),
                                );
                              }),
                          CustomMaterialButton(
                              label: "Route",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RouteRegistration(),
                                  ),
                                );
                              }),
                          CustomMaterialButton(
                              label: "Class",
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ClassRegistration(),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
