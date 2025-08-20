import 'package:flutter/services.dart' show rootBundle;
import 'package:tflite_flutter/tflite_flutter.dart';
import '../core/constants.dart';
import '../core/error_handler.dart';

/// Load TFLite model and labels
class ModelLoader {
  Interpreter? _interpreter;
  List<String> _labels = [];

  Future<void> loadModel() async {
    try {
      _interpreter = await Interpreter.fromAsset(Constants.modelPath);
      _labels = await _loadLabels();
    } catch (e, st) {
      ErrorHandler.logError(e, st);
    }
  }

  Future<List<String>> _loadLabels() async {
    try {
      final raw = await rootBundle.loadString(Constants.labelsPath);
      return raw.split('\n').where((line) => line.isNotEmpty).toList();
    } catch (e, st) {
      ErrorHandler.logError(e, st);
      return [];
    }
  }

  Interpreter? get interpreter => _interpreter;
  List<String> get labels => _labels;
}
