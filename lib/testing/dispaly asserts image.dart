import 'package:flutter/material.dart';

class AssertImage extends StatelessWidget {
  const AssertImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Centered Asset Image'),
      ),
      body: Center(
        child: Image.asset(
          'assets/images/1.jpg',
          width: 200,
          height: 200,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            print('Image Error: $error');
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 48,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Failed to load image',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
