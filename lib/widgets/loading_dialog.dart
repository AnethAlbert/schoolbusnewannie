import 'package:flutter/material.dart';

import '../core/utils/app_colors.dart';

Future<dynamic> loadingDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
              child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: 120,
                height: 120,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
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
              ),
            ),
          )));
}
