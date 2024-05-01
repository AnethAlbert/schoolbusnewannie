import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class indicatorLoading extends StatefulWidget {
      const indicatorLoading({Key? key}) : super(key: key);

      @override
      State<indicatorLoading> createState() => _indicatorLoadingState();
    }

    class _indicatorLoadingState extends State<indicatorLoading> {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body : Center(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Waiting "),
                    SizedBox(width: 2),
                    SpinKitWave(color: Colors.red),
                    // Add more widgets if needed
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }
