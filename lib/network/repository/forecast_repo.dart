import '../../mvvm/models/forecast.dart';
import '../ApiService.dart';
import '../api_endpoints.dart';
import '../constants.dart';

class ForecastRepository {
  final ApiService api;

  ForecastRepository(this.api);

  Future<Forecast> fetchForecast(String city) async {
    final json = await api.get(
      ApiEndpoint.forecast,
      params: {
        'q': city,
        'appid': Constants.API_KEY,
        'units': 'metric',
      },
    );

    return Forecast.fromJson(json);
  }
}