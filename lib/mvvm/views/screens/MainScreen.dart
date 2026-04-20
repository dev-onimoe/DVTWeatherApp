import 'package:flutter/material.dart';
import 'package:flutter_assessment/helpers/view_helpers/boxconstraints_helpers.dart';
import 'package:flutter_assessment/helpers/view_helpers/textstyle_helpers.dart';
import 'package:flutter_assessment/mvvm/view_models/forecast_state.dart';

import '../../../helpers/app_assets.dart';
import '../../view_models/forecast_bloc.dart';
import '../helper_views/temperature_card.dart';

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
            body: Center(child: Text(state.error!)),
          );
        }

        final forecast = state.data!;
        return Stack(
          children: [
            Container(
              constraints: AppBoxConstraint.fullScreen,
              child: Image.asset(Background.sunny),
            ),
            Column(
              spacing: ScreenConstants.column_spacing,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
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
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ScreenConstants.padding),
                    child: ListView.builder(
                        itemCount: forecast.items.length,
                        itemBuilder: (context, index) {
                          return TemperatureCard(forecastItem: forecast.items[index]);
                        }
                    )
                )
              ],
            )
          ],
        );
      }
    );
  }
}