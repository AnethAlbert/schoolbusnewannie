import 'package:flutter/cupertino.dart';

class CupertinoButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const CupertinoButtonWidget({
    required this.buttonText,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      color: CupertinoColors.systemBlue,
      padding: EdgeInsets.all(16.0),
      borderRadius: BorderRadius.circular(8.0),
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: CupertinoColors.white,
        ),
      ),
    );
  }
}
