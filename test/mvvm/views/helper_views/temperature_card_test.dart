import 'package:flutter/material.dart';
import 'package:flutter_assessment/mvvm/models/forecast_item.dart';
import 'package:flutter_assessment/mvvm/models/forecast_main.dart';
import 'package:flutter_assessment/mvvm/views/helper_views/temperature_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TemperatureCard displays day and temperature correctly', (WidgetTester tester) async {
    final forecastItem = ForecastItem(
      date: DateTime(2023, 10, 27),
      main: ForecastMain(
        temp: 25.4,
        feelsLike: 26.0,
        tempMin: 24.0,
        tempMax: 27.0,
        pressure: 1012,
        humidity: 60,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TemperatureCard(forecastItem: forecastItem),
        ),
      ),
    );

    // Check that day is displayed
    expect(find.text('Friday'), findsOneWidget);

    // Check that temperature is displayed (rounded 25.4 to 25)
    expect(find.text('25°'), findsOneWidget);

    // Chaeck that Image.asset is present
    expect(find.byType(Image), findsOneWidget);
  });
}
