import 'package:flutter_assessment/network/constants.dart';
import 'package:flutter_assessment/services/location_services.dart';

import 'mvvm/view_models/forecast_bloc.dart';
import 'network/api_service.dart';
import 'network/repository/forecast_repo.dart';

class AppDependencies {
  static ForecastBloc createForecastBloc() {
    final api = ApiService(Constants.baseUrl);
    final repo = ForecastRepository(api);
    final location = LocationManager();
    return ForecastBloc(repo, location);
  }
}