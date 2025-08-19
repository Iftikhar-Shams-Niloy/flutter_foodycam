import 'dart:io';
import 'package:image/image.dart' as img;
import '../core/constants.dart';

class ImageProcessor {
  /// Preprocesses the image and returns a 3D list [height, width, channels]
  List<List<List<int>>> preprocess(File imageFile) {
    try {
      final imageBytes = imageFile.readAsBytesSync();
      final imageRaw = img.decodeImage(imageBytes);

      if (imageRaw == null) {
        throw Exception("Failed to decode image");
      }

      final resizedImage = img.copyResize(
        imageRaw,
        width: Constants.inputSize,
        height: Constants.inputSize,
      );

      // Verify the image was resized correctly
      if (resizedImage.width != Constants.inputSize ||
          resizedImage.height != Constants.inputSize) {
        throw Exception("Image resize failed");
      }

      // Create 3D array: [height][width][channels]
      final imageData = List.generate(
        Constants.inputSize,
        (y) => List.generate(Constants.inputSize, (x) {
          final pixel = resizedImage.getPixel(x, y);
          // Explicitly cast num to int
          return [
            pixel.r.toInt(),
            pixel.g.toInt(),
            pixel.b.toInt(),
          ]; // [R, G, B]
        }),
      );

      print(
        "✅ Image processed: ${Constants.inputSize}x${Constants.inputSize}x3",
      );
      return imageData;
    } catch (e) {
      print("❌ Image processing failed: $e");
      rethrow;
    }
  }
}
