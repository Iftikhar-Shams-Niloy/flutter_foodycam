import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'model_loader.dart';
import 'image_processor.dart';
import '../domain/entities/prediction.dart';

class PredictionService {
  final ModelLoader _modelLoader;
  final ImageProcessor _imageProcessor;

  PredictionService(this._modelLoader, this._imageProcessor);

  Future<Prediction?> predict(File imageFile) async {
    print("🚀 Starting prediction process...");
    try {
      final interpreter = _modelLoader.interpreter;
      if (interpreter == null) {
        print("❌ Model interpreter is null!");
        return null;
      }

      // Get model input details
      final inputTensor = interpreter.getInputTensors()[0];
      final outputTensor = interpreter.getOutputTensors()[0];

      print("📊 Model input shape: ${inputTensor.shape}");
      print("📊 Model output shape: ${outputTensor.shape}");
      print(
        "📊 Input data type: ${inputTensor.type} (index: ${inputTensor.type.index})",
      );
      print(
        "📊 Output data type: ${outputTensor.type} (index: ${outputTensor.type.index})",
      );

      print("🖼️ Starting image preprocessing...");
      final preprocessedImage = _imageProcessor.preprocess(imageFile);
      print("✅ Image preprocessing completed");

      // Convert to model input format
      print("🔄 Converting image to model input format...");
      final input = preprocessedImage.reshape(inputTensor.shape);
      print("✅ Input converted, shape: ${input.shape}");

      // Prepare output - your model outputs uint8 (0-255)
      print("📦 Preparing output buffer...");

      // Always use int output since your model returns uint8
      final output = List<int>.filled(
        outputTensor.shape.reduce((a, b) => a * b),
        0,
      ).reshape(outputTensor.shape);

      // Run inference
      interpreter.run(input, output);

      // Convert uint8 outputs (0-255) to probabilities (0.0-1.0)
      final uint8Output = output[0] as List<int>;
      final probabilities = uint8Output.map((val) => val / 255.0).toList();

      print("✅ Inference completed successfully");
      print("📈 Output probabilities length: ${probabilities.length}");

      // Debug: print top 5 predictions
      final sortedIndices = List.generate(probabilities.length, (i) => i)
        ..sort((a, b) => probabilities[b].compareTo(probabilities[a]));

      for (int i = 0; i < 5 && i < sortedIndices.length; i++) {
        final idx = sortedIndices[i];
        print(
          "   Top ${i + 1}: ${_modelLoader.labels[idx]} (${(probabilities[idx] * 100).toStringAsFixed(2)}%)",
        );
      }

      // Find the highest confidence prediction
      double maxConfidence = 0;
      int maxIndex = -1;
      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > maxConfidence) {
          maxConfidence = probabilities[i];
          maxIndex = i;
        }
      }

      print("🎯 Max confidence: $maxConfidence at index: $maxIndex");

      if (maxIndex == -1) {
        print("❌ No valid prediction found");
        return null;
      }

      // Check if labels are loaded correctly
      if (_modelLoader.labels.isEmpty) {
        print("❌ Labels list is empty!");
        return null;
      }

      if (maxIndex >= _modelLoader.labels.length) {
        print(
          "❌ Index $maxIndex out of bounds for labels list (length: ${_modelLoader.labels.length})",
        );
        return null;
      }

      final prediction = Prediction(
        label: _modelLoader.labels[maxIndex],
        confidence: maxConfidence,
      );

      print(
        "🏆 Prediction result: ${prediction.label} (${(prediction.confidence * 100).toStringAsFixed(2)}%)",
      );
      return prediction;
    } catch (e, st) {
      print("💥 CRITICAL ERROR: $e");
      print("Stack trace: $st");
      return null;
    }
  }
}
