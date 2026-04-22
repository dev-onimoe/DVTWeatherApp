import 'package:flutter/material.dart';
import 'package:flutter_assessment/helpers/app_assets.dart';
import 'package:flutter_assessment/helpers/view_helpers/textstyle_helpers.dart';

import '../../models/forecast_item.dart';

class TemperatureCard extends StatelessWidget {

  final ForecastItem forecastItem;

  const TemperatureCard({super.key, required this.forecastItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: ScreenConstants.cardHeight
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenConstants.cardCornerRadius)
      ),
      child: Padding(
        padding: const EdgeInsets.all(ScreenConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ScreenConstants.columnSpacing),
                child: Text(
                  forecastItem.day,
                  textAlign: TextAlign.start,
                  style: AppTextStyles.cardTitle,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ScreenConstants.padding),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        AppElments.sun,
                        width: 80,
                        height: 80,
                      ),
                      Text(
                        forecastItem.main.temp.parsedDegreeValue(),
                        style: AppTextStyles.temperature,
                      )
                    ]
                ),
              )
            ]
        ),
      )
    );
  }
}

extension on double {
  String parsedDegreeValue() {
    return '${round()}°';
  }
}