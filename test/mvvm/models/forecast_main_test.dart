import 'package:flutter_assessment/mvvm/models/forecast_main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForecastMain', () {
    test('fromJson should return a valid ForecastMain object', () {
      final json = {
        'temp': 25.5,
        'feels_like': 26.0,
        'temp_min': 24.0,
        'temp_max': 27.0,
        'pressure': 1012,
        'humidity': 60,
      };

      final forecastMain = ForecastMain.fromJson(json);

      expect(forecastMain.temp, 25.5);
      expect(forecastMain.feelsLike, 26.0);
      expect(forecastMain.tempMin, 24.0);
      expect(forecastMain.tempMax, 27.0);
      expect(forecastMain.pressure, 1012);
      expect(forecastMain.humidity, 60);
    });

    test('fromJson should handle integer values for doubles', () {
      final json = {
        'temp': 25,
        'feels_like': 26,
        'temp_min': 24,
        'temp_max': 27,
        'pressure': 1012,
        'humidity': 60,
      };

      final forecastMain = ForecastMain.fromJson(json);

      expect(forecastMain.temp, 25.0);
      expect(forecastMain.feelsLike, 26.0);
      expect(forecastMain.tempMin, 24.0);
      expect(forecastMain.tempMax, 27.0);
    });
  });
}
