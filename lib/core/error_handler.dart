/// Simple error handler utility for logging and showing errors
class ErrorHandler {
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    // For now, just print. Later integrate logger / crashlytics if needed.
    print("Error: $error");
    if (stackTrace != null) {
      print("StackTrace: $stackTrace");
    }
  }
}
