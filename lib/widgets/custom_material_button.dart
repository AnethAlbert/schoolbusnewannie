import 'package:flutter/material.dart';

import 'package:newschoolbusapp/style/theme.dart' as Theme;

import '../core/utils/app_colors.dart';

class CustomMaterialButton extends StatelessWidget {
  final String label;
  final Function() onPressed;

  const CustomMaterialButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(1.0, 6.0),
            blurRadius: 20.0,
          ),
        ],
        gradient: const LinearGradient(
            colors: [
              AppColors.linearTop,
              AppColors.linearMiddle,
            ],
            begin: FractionalOffset(0.2, 0.2),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
        highlightColor: Colors.transparent,
        splashColor: Theme.Colors.loginGradientEnd,
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
          child: Text(
            label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "WorkSansBold"),
          ),
        ),
      ),
    );
  }
}
