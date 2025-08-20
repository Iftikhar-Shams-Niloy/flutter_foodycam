class DebugLogger {
  static void log(String message) {
    print("🐛 DEBUG: $message");
  }

  static void info(String message) {
    print("ℹ️ INFO: $message");
  }

  static void success(String message) {
    print("✅ SUCCESS: $message");
  }

  static void warning(String message) {
    print("⚠️ WARNING: $message");
  }

  static void error(String message) {
    print("❌ ERROR: $message");
  }

  static void modelInfo(String tensorType, dynamic info) {
    print("📊 MODEL $tensorType: $info");
  }

  static void predictionStep(String step) {
    print("🔄 $step");
  }

  static void predictionResult(String label, double confidence) {
    print("🏆 PREDICTION: $label (${(confidence * 100).toStringAsFixed(2)}%)");
  }

  static void topPredictions(
    List<String> labels,
    List<double> probabilities,
    int count,
  ) {
    final sortedIndices = List.generate(probabilities.length, (i) => i)
      ..sort((a, b) => probabilities[b].compareTo(probabilities[a]));

    for (int i = 0; i < count && i < sortedIndices.length; i++) {
      final idx = sortedIndices[i];
      log(
        "Top ${i + 1}: ${labels[idx]} (${(probabilities[idx] * 100).toStringAsFixed(2)}%)",
      );
    }
  }

  static void tensorInfo(
    String name,
    dynamic shape,
    dynamic type, [
    dynamic index,
  ]) {
    if (index != null) {
      print("🧮 $name - Shape: $shape, Type: $type, Index: $index");
    } else {
      print("🧮 $name - Shape: $shape, Type: $type");
    }
  }
}
