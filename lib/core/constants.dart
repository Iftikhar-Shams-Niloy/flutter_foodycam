import 'package:flutter/material.dart';

class Constants {
  static const int inputSize = 192;
  static const double mean = 0;
  static const double std = 255;

  static const String modelPath = "assets/food_101_model.tflite";
  static const String labelsPath = "assets/food_101_labels.txt";
}

// Custom colors
const Color customPurple = Color.fromARGB(255, 69, 45, 112);
const Color customPurple2 = Color.fromARGB(255, 36, 22, 61);

var colorSchemeLight = ColorScheme.fromSeed(seedColor: customPurple);
var colorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: customPurple2,
);
