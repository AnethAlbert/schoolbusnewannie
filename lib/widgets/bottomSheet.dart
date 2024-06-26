import 'package:flutter/material.dart';
import 'package:newschoolbusapp/style/theme.dart' as Theme;

class CustomBottomSheet extends StatefulWidget {
  final Widget content;

  const CustomBottomSheet({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget content,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true, // Extend to full screen
      builder: (context) => CustomBottomSheet(content: content),
    );
  }
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 30, // Adjust height as needed
              color: Colors.transparent,
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.Colors.loginGradientStart,
                    Theme.Colors.loginGradientEnd,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
