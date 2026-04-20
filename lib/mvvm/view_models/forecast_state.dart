import '../models/forecast.dart';

class ForecastState {
  final bool loading;
  final Forecast? data;
  final String? error;

  ForecastState({
    required this.loading,
    this.data,
    this.error,
  });

  factory ForecastState.initial() {
    return ForecastState(loading: false);
  }

  factory ForecastState.loading() {
    return ForecastState(loading: true);
  }

  factory ForecastState.success(Forecast data) {
    return ForecastState(loading: false, data: data);
  }

  factory ForecastState.failure(String error) {
    return ForecastState(loading: false, error: error);
  }
}