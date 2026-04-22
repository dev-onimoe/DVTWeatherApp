import '../../mvvm/models/forecast.dart';
import '../../mvvm/models/forecast_item.dart';
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

    Forecast forecast = Forecast.fromJson(json);
    return forecast.filterToMiddayPerDay();
  }
}

extension ForecastFiltering on Forecast {
  Forecast filterToMiddayPerDay() {
    final Map<String, ForecastItem> bestPerDay = {};

    for (final item in items) {
      final date = item.date;

      final dayKey = "${date.year}-${date.month}-${date.day}";
      final midday = DateTime(date.year, date.month, date.day, 12);

      final diff = (date.difference(midday)).inMinutes.abs();

      if (!bestPerDay.containsKey(dayKey)) {
        if (bestPerDay.length < 5) {
          bestPerDay[dayKey] = item;
        }
      } else {
        final existing = bestPerDay[dayKey]!;
        final existingDiff = (existing.date.difference(midday)).inMinutes.abs();

        if (diff < existingDiff) {
          if (bestPerDay.length < 5) {
            bestPerDay[dayKey] = item;
          }
        }
      }
    }

    return Forecast(
      items: bestPerDay.values.toList()
        ..sort((a, b) => a.date.compareTo(b.date)),
      city: city,
      country: country,
      timezone: timezone,
    );
  }
}