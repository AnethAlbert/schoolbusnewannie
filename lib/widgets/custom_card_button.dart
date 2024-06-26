import 'package:flutter/material.dart';
import 'package:newschoolbusapp/core/utils/app_colors.dart';

class CustomCardButton extends StatelessWidget {
  final Function() onTap;
  final String label;
  final bool showBorder;

  const CustomCardButton({
    super.key,
    required this.label,
    required this.onTap,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: showBorder ? Colors.transparent : Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: showBorder
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: showBorder ? Colors.white : AppColors.linearMiddle,
            ),
          ),
        ),
      ),
    );
  }
}
