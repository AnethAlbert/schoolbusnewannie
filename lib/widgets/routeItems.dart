import 'package:flutter/material.dart';
import 'package:newschoolbusapp/models/route.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class RouteItem extends StatelessWidget {
  final RouteClass route;

  const RouteItem({Key? key, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [
          BoxShadow(
            color: Theme.Colors.loginGradientStart,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
          BoxShadow(
            color: Theme.Colors.loginGradientEnd,
            offset: Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: LinearGradient(
          colors: [Theme.Colors.loginGradientEnd, Theme.Colors.loginGradientStart],
          begin: const FractionalOffset(0.2, 0.2),
          end: const FractionalOffset(1.0, 1.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: Theme.Colors.loginGradientEnd,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            route.name ?? '', // Display route name, use default value if null
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontFamily: "WorkSansBold",
            ),
          ),
        ),
        onPressed: () {
          // Handle button press for the route
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Container(
                  width: 300,
                  height: 200,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(route.name ?? ''), // Display route name
                      SizedBox(height: 10),
                      Text("Add your custom content here"),
                      SizedBox(height: 10),
                      MaterialButton(
                        onPressed: () {
                          // Handle button press action
                          // For example, navigate to another screen
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => NextScreen()),
                          // );
                        },
                        child: Text("Next"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
