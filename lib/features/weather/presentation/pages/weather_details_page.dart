import 'package:flutter/material.dart';

import '../../../../core/entities/city_weather.dart';
import '../../../../core/theme/app_dimensions.dart';

class WeatherDetailPage extends StatelessWidget {
  final CityWeather cityWeather;

  const WeatherDetailPage({required this.cityWeather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppDimensions.paddingLarge,
              horizontal: AppDimensions.paddingRegular,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 20.0,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
