import 'package:flutter_assessment/mvvm/models/forecast.dart';
import 'package:flutter_assessment/network/ApiService.dart';
import 'package:flutter_assessment/network/api_endpoints.dart';
import 'package:flutter_assessment/network/repository/forecast_repo.dart';
import 'package:flutter_test/flutter_test.dart';

class MockApiService implements ApiService {
  @override
  String get baseUrl => '';

  Map<String, dynamic>? response;

  @override
  Future<Map<String, dynamic>> get(
    ApiEndpoint endpoint, {
    Map<String, String>? params,
    Duration timeout = const Duration(seconds: 10),
  }) async {
    return response!;
  }
}

void main() {
  late ForecastRepository repository;
  late MockApiService mockApi;

  setUp(() {
    mockApi = MockApiService();
    repository = ForecastRepository(mockApi);
  });

  group('ForecastRepository', () {
    test('fetchForecast returns filtered forecast on success', () async {
      mockApi.response = {
        'list': [
          {
            'dt_txt': '2023-10-27 12:00:00',
            'main': {'temp': 25.0, 'feels_like': 25.0, 'temp_min': 20.0, 'temp_max': 30.0, 'pressure': 1000, 'humidity': 50}
          }
        ],
        'city': {'name': 'Lagos', 'country': 'NG', 'timezone': 3600}
      };

      final result = await repository.fetchForecast('Lagos');

      expect(result.city, 'Lagos');
      expect(result.items.length, 1);
    });
  });
}
