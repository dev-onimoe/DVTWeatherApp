import 'forecast_item.dart';

class Forecast {
  final List<ForecastItem> items;
  final String city;
  final String country;
  final int timezone;

  Forecast({
    required this.items,
    required this.city,
    required this.country,
    required this.timezone,
  });

  factory Forecast.fromJson(Map<String, dynamic> json) {
    final cityJson = json['city'];

    return Forecast(
      items: (json['list'] as List<dynamic>)
          .map((e) => ForecastItem.fromJson(e))
          .toList(),
      city: cityJson['name'],
      country: cityJson['country'],
      timezone: cityJson['timezone'],
    );
  }
}
