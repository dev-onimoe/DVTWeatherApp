import 'package:flutter_assessment/mvvm/models/forecast_item.dart';
import 'package:flutter_assessment/mvvm/models/forecast_main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ForecastItem', () {
    test('fromJson should return a valid ForecastItem object', () {
      final json = {
        'dt_txt': '2023-10-27 12:00:00',
        'main': {
          'temp': 25.5,
          'feels_like': 26.0,
          'temp_min': 24.0,
          'temp_max': 27.0,
          'pressure': 1012,
          'humidity': 60,
        },
      };

      final forecastItem = ForecastItem.fromJson(json);

      expect(forecastItem.main.temp, 25.5);
      expect(forecastItem.date, DateTime(2023, 10, 27, 12));
    });

    test('day getter should return correct day name', () {
      final date = DateTime(2023, 10, 27);
      final forecastItem = ForecastItem(
        main: _realMockMain(25),
        date: date,
      );

      expect(forecastItem.day, 'Friday');
    });

    test('weather getter should return correct Weather enum based on temperature', () {
      expect(ForecastItem(main: _realMockMain(26), date: DateTime.now()).weather, Weather.sunny);
      expect(ForecastItem(main: _realMockMain(25), date: DateTime.now()).weather, Weather.sunny);
      expect(ForecastItem(main: _realMockMain(24), date: DateTime.now()).weather, Weather.cloudy);
      expect(ForecastItem(main: _realMockMain(20), date: DateTime.now()).weather, Weather.cloudy);
      expect(ForecastItem(main: _realMockMain(19), date: DateTime.now()).weather, Weather.rainy);
    });
  });
}

ForecastMain _realMockMain(double temp) {
  return ForecastMain(
    temp: temp,
    feelsLike: temp,
    tempMin: temp,
    tempMax: temp,
    pressure: 1000,
    humidity: 50,
  );
}
