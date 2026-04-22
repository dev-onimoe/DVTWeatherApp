import 'forecast_main.dart';

class ForecastItem {
  final ForecastMain main;
  final DateTime date;

  ForecastItem({
    required this.main,
    required this.date,
  });

  Weather get weather => Weather.fromTemp(main.temp);

  factory ForecastItem.fromJson(Map<String, dynamic> json) {
    final rawDate = json['dt_txt'] as String;

    return ForecastItem(
      main: ForecastMain.fromJson(json['main']),
      date: DateTime.parse(rawDate.replaceAll(' ', 'T')),
    );
  }

  String get day {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[date.weekday - 1];
  }
}

enum Weather {
  cloudy,
  sunny,
  rainy;

  static Weather fromTemp(double temp) {
    if (temp >= 25) {
      return Weather.sunny;
    } else if (temp >= 20) {
      return Weather.cloudy;
    } else {
      return Weather.rainy;
    }
  }
}