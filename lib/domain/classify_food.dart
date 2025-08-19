import 'dart:io';
import '../data/prediction_service.dart';
import 'prediction.dart';

class ClassifyFood {
  final PredictionService _service;

  ClassifyFood(this._service);

  Future<Prediction?> execute(File imageFile) async {
    return await _service.predict(imageFile);
  }
}
