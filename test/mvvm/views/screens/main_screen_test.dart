import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/mvvm/models/forecast.dart';
import 'package:flutter_assessment/mvvm/models/forecast_item.dart';
import 'package:flutter_assessment/mvvm/models/forecast_main.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_bloc.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_state.dart';
import 'package:flutter_assessment/mvvm/views/screens/main_screen.dart';
import 'package:flutter_assessment/network/repository/forecast_repo.dart';
import 'package:flutter_assessment/services/location_services.dart';
import 'package:flutter_test/flutter_test.dart';

class MockForecastBloc implements ForecastBloc {
  final _controller = StreamController<ForecastState>.broadcast();
  
  @override
  Stream<ForecastState> get stream => _controller.stream;

  @override
  ForecastRepository get repository => throw UnimplementedError();
  @override
  LocationManager get locationManager => throw UnimplementedError();

  bool fetchCalled = false;
  bool disposed = false;

  @override
  void fetchUsingCity() {
    fetchCalled = true;
  }

  @override
  void dispose() {
    disposed = true;
    _controller.close();
  }

  void emit(ForecastState state) => _controller.add(state);
}

void main() {
  late MockForecastBloc mockBloc;

  setUp(() {
    mockBloc = MockForecastBloc();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: MainScreen(bloc: mockBloc),
    );
  }

  testWidgets('shows loading indicator when state is loadin', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    mockBloc.emit(ForecastState.loading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when state has error', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    mockBloc.emit(ForecastState.failure('Something went wrong'));
    await tester.pump();

    expect(find.text('Something went wrong'), findsOneWidget);
  });

  testWidgets('shows forecast list when state is success', (tester) async {
    final forecast = Forecast(
      city: 'Lagos',
      country: 'NG',
      timezone: 3600,
      items: [
        ForecastItem(
          date: DateTime.now(),
          main: ForecastMain(
            temp: 30.4,
            feelsLike: 31.0,
            tempMin: 29.0,
            tempMax: 32.0,
            pressure: 1010,
            humidity: 70,
          ),
        ),
      ],
    );

    await tester.pumpWidget(createWidgetUnderTest());
    mockBloc.emit(ForecastState.success(forecast));
    await tester.pump();

    expect(find.text('5 Day Forecast'), findsOneWidget);
    expect(find.text('30°'), findsOneWidget);
  });
}
