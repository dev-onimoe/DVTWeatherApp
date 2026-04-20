import 'dart:async';

import '../../network/repository/forecast_repo.dart';
import '../../services/location_services.dart';
import 'forecast_state.dart';

class ForecastBloc {
  final ForecastRepository repository;

  final _controller = StreamController<ForecastState>.broadcast();
  final LocationManager locationManager;

  Stream<ForecastState> get stream => _controller.stream;

  ForecastBloc(this.repository, this.locationManager) {
    _controller.add(ForecastState.initial());
  }

  void fetchUsingCity() async {
    _controller.add(ForecastState.loading());

    try {
      final city = await locationManager.resolveCity();
      final result = await repository.fetchForecast(city);
      _controller.add(ForecastState.success(result));
    } catch (e) {
      _controller.add(ForecastState.failure(e.toString()));
    }
  }

  void dispose() {
    _controller.close();
  }
}