import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageUtils {
  static Future<String> compressImage(Uint8List? imageBytes) async {
    if (imageBytes == null) return "";

    final int maxSizeKB = 60;

    print("COMPRESSED00");

    // Compress the image
    List<int> compressedImage = await FlutterImageCompress.compressWithList(
      imageBytes,
      minHeight: 1920,
      minWidth: 1080,
      quality: 25, // Adjust the quality to lower the file size
    );

    print("COMPRESSED01");

    // Check if compressed image is within size limits
    // while (compressedImage.length > maxSizeKB * 1024) {
    //   compressedImage = await FlutterImageCompress.compressWithList(
    //     compressedImage as Uint8List,
    //     minHeight: 1920,
    //     minWidth: 1080,
    //     quality: 85,
    //   );
    // }
    //
    // print("COMPRESSED02");

    // Encode compressed image to base64 string
    String base64Image = base64Encode(compressedImage);

    return base64Image;
  }
}
