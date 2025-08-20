class ErrorHandler {
  static void logError(dynamic error, [StackTrace? stackTrace]) {
    print("!!! ERROR FOUND: $error !!!");
    if (stackTrace != null) {
      print("StackTrace: $stackTrace");
    }
  }
}
