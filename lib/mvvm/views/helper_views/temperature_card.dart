import 'package:flutter/material.dart';
import 'package:flutter_assessment/helpers/app_assets.dart';
import 'package:flutter_assessment/helpers/view_helpers/textstyle_helpers.dart';

import '../../models/forecast_item.dart';

class TemperatureCard extends StatelessWidget {

  final ForecastItem forecastItem;

  const TemperatureCard({required this.forecastItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: double.infinity,
        minHeight: ScreenConstants.card_height
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ScreenConstants.card_corner_raduis)
      ),
      child: Padding(
        padding: const EdgeInsets.all(ScreenConstants.padding),
        child: Column(
            spacing: ScreenConstants.column_spacing,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                forecastItem.day,
                style: AppTextStyles.card_title,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: ScreenConstants.padding),
                child: Row(
                    children: [
                      Image.asset(
                        AppElments.sun,
                        width: 70,
                        height: 70,
                      ),
                      Text(
                        '${forecastItem.main.temp}°',
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