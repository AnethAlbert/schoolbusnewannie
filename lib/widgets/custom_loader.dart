import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.linearMiddle,
              strokeCap: StrokeCap.round,
              strokeWidth: 8,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Loading"),
          ],
        ),
      ),
    );
  }
}
