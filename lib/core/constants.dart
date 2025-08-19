/// Core constants for model input/output
class Constants {
  static const int inputSize = 192; // Example model input size (224x224)
  static const double mean = 127.5; // Normalization mean (if required)
  static const double std = 255; // Normalization std (if required)

  static const String modelPath = "assets/food_101_model.tflite";
  static const String labelsPath = "assets/food_101_labels.txt";
}
