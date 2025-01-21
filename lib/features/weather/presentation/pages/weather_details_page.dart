import 'package:flutter/material.dart';

import '../../../../core/entities/city_weather.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../widgets/daily_forecast_widgets.dart';
import '../widgets/hourly_forecast_widgets.dart';
import '../widgets/main_weather_section.dart';
import '../widgets/miscellaneous_stats_section.dart';
import '../widgets/sun_timing_widgets.dart';
import '../widgets/weather_details_header.dart';

class WeatherDetailPage extends StatelessWidget {
  final CityWeather cityWeather;

  const WeatherDetailPage({required this.cityWeather});

  @override
  Widget build(BuildContext context) {
    final weather = cityWeather.weather;
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
              children: [
                WeatherDetailsHeader(city: cityWeather.city),
                MainWeatherSection(weather: weather),
                HourlyForecastSection(hourlyForecast: weather.hourly),
                SunTimingSection(data: weather.current),
                MiscellaneousStatsSection(data: weather.current),
                DailyForecastSection(dailyForecast: weather.daily),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
