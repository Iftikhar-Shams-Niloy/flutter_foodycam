import 'dart:io';
import 'package:image/image.dart' as img;
import '../core/constants.dart';
import '../core/error_handler.dart';

class ImageProcessor {
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

      if (resizedImage.width != Constants.inputSize ||
          resizedImage.height != Constants.inputSize) {
        throw Exception("Image resize failed");
      }

      final imageData = List.generate(
        Constants.inputSize,
        (y) => List.generate(Constants.inputSize, (x) {
          final pixel = resizedImage.getPixel(x, y);
          return [
            pixel.r.toInt(),
            pixel.g.toInt(),
            pixel.b.toInt(),
          ]; // [R, G, B]
        }),
      );

      return imageData;
    } catch (error, stackTrace) {
      ErrorHandler.logError(error, stackTrace);
      rethrow;
    }
  }
}
