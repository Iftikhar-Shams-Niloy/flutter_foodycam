import 'dart:io';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'model_loader.dart';
import 'image_processor.dart';
import '../domain/prediction.dart';
import '../core/error_handler.dart';
import '../core/debug_logger.dart';

class PredictionService {
  final ModelLoader _modelLoader;
  final ImageProcessor _imageProcessor;

  PredictionService(this._modelLoader, this._imageProcessor);

  Future<Prediction?> predict(File imageFile) async {
    DebugLogger.predictionStep("<<< Starting Prediction >>>");

    try {
      final interpreter = _modelLoader.interpreter;
      if (interpreter == null) {
        DebugLogger.error("<<< Null Model Interpreter >>>");
        return null;
      }

      final inputTensor = interpreter.getInputTensors()[0];
      final outputTensor = interpreter.getOutputTensors()[0];

      DebugLogger.tensorInfo(
        "Input",
        inputTensor.shape,
        inputTensor.type,
        inputTensor.type.index,
      );
      DebugLogger.tensorInfo(
        "Output",
        outputTensor.shape,
        outputTensor.type,
        outputTensor.type.index,
      );

      DebugLogger.predictionStep("<<< Starting Image Processing >>>");
      final preprocessedImage = _imageProcessor.preprocess(imageFile);
      DebugLogger.success("<<< Image Preprocessing Completed >>>");

      DebugLogger.predictionStep("<<< Converting Image >>>");
      final input = preprocessedImage.reshape(inputTensor.shape);
      DebugLogger.modelInfo("<<< Input Converted Shape: >>>", input.shape);

      DebugLogger.predictionStep("<<< Preparing Output Buffer >>>");

      // Always use int output since model uint8
      final output = List<int>.filled(
        outputTensor.shape.reduce((a, b) => a * b),
        0,
      ).reshape(outputTensor.shape);

      // Run inference
      interpreter.run(input, output);

      // Convert uint8 outputs (0-255) to probabilities (0.0-1.0)
      final uint8Output = output[0] as List<int>;
      final probabilities = uint8Output.map((val) => val / 255.0).toList();

      DebugLogger.success("<<< Inference completed successfully >>>");
      DebugLogger.modelInfo(
        "<<< Output probabilities length >>>",
        probabilities.length,
      );

      // DebugLogger.topPredictions(_modelLoader.labels, probabilities, 5);

      double maxConfidence = 0;
      int maxIndex = -1;
      for (int i = 0; i < probabilities.length; i++) {
        if (probabilities[i] > maxConfidence) {
          maxConfidence = probabilities[i];
          maxIndex = i;
        }
      }

      DebugLogger.modelInfo(
        "<<< Max confidence >>>",
        "$maxConfidence at index: $maxIndex",
      );

      if (maxIndex == -1) {
        DebugLogger.error("<<< No Prediction! >>>");
        return null;
      }

      if (_modelLoader.labels.isEmpty) {
        DebugLogger.error("<<< Labels List Empty! >>>");
        return null;
      }

      if (maxIndex >= _modelLoader.labels.length) {
        DebugLogger.error(
          "<<< Label List Index $maxIndex out of bound (${_modelLoader.labels.length}) >>>",
        );
        return null;
      }

      final prediction = Prediction(
        label: _modelLoader.labels[maxIndex],
        confidence: maxConfidence,
      );

      DebugLogger.predictionResult(prediction.label, prediction.confidence);
      return prediction;
    } catch (e, st) {
      ErrorHandler.logError(e, st);
      return null;
    }
  }
}
