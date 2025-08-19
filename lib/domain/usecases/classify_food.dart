import 'dart:io';
import '../../data/prediction_service.dart';
import '../entities/prediction.dart';

/// Use case to classify food image
class ClassifyFood {
  final PredictionService _service;

  ClassifyFood(this._service);

  Future<Prediction?> execute(File imageFile) async {
    return await _service.predict(imageFile);
  }
}
