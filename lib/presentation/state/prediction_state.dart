import '../../domain/entities/prediction.dart';

/// Simple prediction state model
class PredictionState {
  final bool isLoading;
  final Prediction? prediction;
  final String? error;

  PredictionState({this.isLoading = false, this.prediction, this.error});

  PredictionState copyWith({
    bool? isLoading,
    Prediction? prediction,
    String? error,
  }) {
    return PredictionState(
      isLoading: isLoading ?? this.isLoading,
      prediction: prediction ?? this.prediction,
      error: error ?? this.error,
    );
  }
}
