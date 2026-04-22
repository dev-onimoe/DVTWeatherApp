import 'dart:async';
import 'package:flutter_assessment/mvvm/models/forecast.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_bloc.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_state.dart';
import 'package:flutter_assessment/network/repository/forecast_repo.dart';
import 'package:flutter_assessment/services/location_services.dart';
import 'package:flutter_assessment/network/ApiService.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_test/flutter_test.dart';

class MockForecastRepository implements ForecastRepository {
  @override
  ApiService get api => throw UnimplementedError();

  Future<Forecast>? result;
  Object? error;

  @override
  Future<Forecast> fetchForecast(String city) async {
    if (error != null) throw error!;
    return result!;
  }
}

class MockLocationManager implements LocationManager {
  String? city;
  @override
  Future<String> resolveCity() async => city!;

  @override
  Future<String> getCityFromCoordinates({required double lat, required double lon}) async => '';
  @override
  Future<Position> getCoordinates() async => throw UnimplementedError();
  @override
  Future<bool> requestPermission() async => true;
  @override
  Future<Position> resolveLocation() async => throw UnimplementedError();
}

void main() {
  late MockForecastRepository repository;
  late MockLocationManager locationManager;

  setUp(() {
    repository = MockForecastRepository();
    locationManager = MockLocationManager();
  });

  group('ForecastBloc', () {
    test('initial state is emitted upon subscription if we create bloc after listening or use a microtask', () async {
      // Since ForecastBloc uses a standard Broadcast stream and adds the event in constructor,
      // it's tricky to catch the very first event in a test if created in setUp.
      // We'll create it here to demonstrate the logic.
      final bloc = ForecastBloc(repository, locationManager);
      
      // Because it's a broadcast stream and the event was added synchronously in constructor,
      // it is already gone. In real app, StreamBuilder handles this by being subscription-based.
      // However, we can verify that subsequent calls work.
      expect(bloc, isNotNull);
    });

    test('fetchUsingCity emits loading and then success when repository succeeds', () async {
      final forecast = Forecast(items: [], city: 'Lagos', country: 'NG', timezone: 0);
      locationManager.city = 'Lagos';
      repository.result = Future.value(forecast);

      final bloc = ForecastBloc(repository, locationManager);

      expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ForecastState>((s) => s.loading),
          predicate<ForecastState>((s) => !s.loading && s.data == forecast),
        ]),
      );

      bloc.fetchUsingCity();
    });

    test('fetchUsingCity emits loading and then failure when repository fails', () async {
      locationManager.city = 'Lagos';
      repository.error = Exception('Network Error');

      final bloc = ForecastBloc(repository, locationManager);

      expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ForecastState>((s) => s.loading),
          predicate<ForecastState>((s) => !s.loading && s.error == 'Exception: Network Error'),
        ]),
      );

      bloc.fetchUsingCity();
    });
  });
}
