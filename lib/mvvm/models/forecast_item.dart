import 'forecast_main.dart';

class ForecastItem {
  final ForecastMain main;
  final DateTime date;

  ForecastItem({
    required this.main,
    required this.date,
  });

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