import 'package:flutter_assessment/mvvm/models/forecast.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForecastState', () {
    test('initial factory returns loading false', () {
      final state = ForecastState.initial();
      expect(state.loading, false);
      expect(state.data, isNull);
      expect(state.error, isNull);
    });

    test('loading factory returns loading true', () {
      final state = ForecastState.loading();
      expect(state.loading, true);
    });

    test('success factory returns correct data', () {
      final forecast = Forecast(items: [], city: '', country: '', timezone: 0);
      final state = ForecastState.success(forecast);
      expect(state.loading, false);
      expect(state.data, forecast);
    });

    test('failure factory returns correct error message', () {
      final state = ForecastState.failure('error');
      expect(state.loading, false);
      expect(state.error, 'error');
    });
  });
}
