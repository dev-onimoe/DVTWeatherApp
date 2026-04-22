import 'package:flutter_assessment/mvvm/models/forecast.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Forecast', () {
    test('fromJson should return a valid Forecast object', () {
      final json = {
        'list': [
          {
            'dt_txt': '2023-10-27 12:00:00',
            'main': {
              'temp': 25.5,
              'feels_like': 26.0,
              'temp_min': 24.0,
              'temp_max': 27.0,
              'pressure': 1012,
              'humidity': 60,
            },
          }
        ],
        'city': {
          'name': 'Lagos',
          'country': 'NG',
          'timezone': 3600,
        },
      };

      final forecast = Forecast.fromJson(json);

      expect(forecast.city, 'Lagos');
      expect(forecast.country, 'NG');
      expect(forecast.timezone, 3600);
      expect(forecast.items.length, 1);
      expect(forecast.items.first.main.temp, 25.5);
    });
  });
}
