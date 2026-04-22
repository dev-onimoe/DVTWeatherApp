import 'package:flutter/material.dart';
import 'package:flutter_assessment/helpers/view_helpers/boxconstraints_helpers.dart';
import 'package:flutter_assessment/helpers/view_helpers/textstyle_helpers.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_state.dart';

import '../../../helpers/app_assets.dart';
import '../../models/forecast_item.dart';
import '../../view_models/forecast_bloc.dart';
import '../helper_views/temperature_card.dart';
import '../helper_views/error_view.dart';

class MainScreen extends StatefulWidget {
  final ForecastBloc bloc;

  const MainScreen({super.key, required this.bloc});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  void initState() {
    super.initState();
    widget.bloc.fetchUsingCity();
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ForecastState> (
      stream: widget.bloc.stream,
      builder: (context, snapshot) {
        final state = snapshot.data;

        if (state == null || state.loading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.error != null) {
          return Scaffold(
            body: ErrorView(
              errorMessage: state.error!,
              onRetry: () => widget.bloc.fetchUsingCity(),
            ),
          );
        }

        final forecast = state.data!;
        final todaysForecast = forecast.items.first;

        return Scaffold(
          body: Stack(
            children: [
              Container(
                constraints: AppBoxConstraint.fullScreen,
                child: Image.asset(
                    todaysForecast.weather == Weather.sunny ? Background.sunny : (todaysForecast.weather == Weather.cloudy ? Background.cloudy : Background.rainy),
                    fit: BoxFit.cover
                ),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(ScreenConstants.padding),
                      child: Text(
                        ScreenConstants.title,
                        textAlign: TextAlign.start,
                        style: AppTextStyles.title,
                      ),
                    ),
                    SizedBox(
                        height: 1,
                        child: Container(color: Colors.white)
                    ),
                    Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(ScreenConstants.padding*2),
                          itemCount: forecast.items.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: ScreenConstants.cardSpacing),
                              child: TemperatureCard(forecastItem: forecast.items[index]),
                            );
                          }
                        )
                    )
                  ],
                ),
              )
            ],
          ),
        );
      }
    );
  }
}