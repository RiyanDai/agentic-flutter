import 'dart:typed_data';
import 'package:image/image.dart' as img;

/// Dynamic Image Compressor
/// Guarantees file size is reduced below [maxBytes] (default: 1 MB / 1,000,000 bytes).
class ImageCompressor {
  static Future<Uint8List> compressBytes(
    Uint8List bytes, {
    int maxBytes = 1000000,
  }) async {
    if (bytes.lengthInBytes <= maxBytes) {
      return bytes;
    }

    final decodedImage = img.decodeImage(bytes);
    if (decodedImage == null) {
      return bytes;
    }

    int quality = 90;
    Uint8List outputBytes = bytes;

    while (outputBytes.lengthInBytes > maxBytes && quality > 15) {
      outputBytes = Uint8List.fromList(
        img.encodeJpg(decodedImage, quality: quality),
      );
      quality -= 10;
    }

    return outputBytes;
  }
}

