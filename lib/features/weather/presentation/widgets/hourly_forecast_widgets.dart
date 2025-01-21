import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/weather_data.dart';

class HourlyForecastSection extends StatelessWidget {
  const HourlyForecastSection({
    super.key,
    required this.hourlyForecast,
  });

  final List<WeatherData> hourlyForecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(
          AppDimensions.cornerRadiusLarge,
        ),
      ),
      child: ListView.separated(
        itemCount: hourlyForecast.length,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
        ),
        separatorBuilder: (context, index) => const VerticalDivider(
          indent: 32.0,
          endIndent: 32.0,
          color: AppColors.textSecondary,
          thickness: 0.5,
        ),
        itemBuilder: (context, index) => HourlyWeatherCard(
          hourlyForecast: hourlyForecast[index],
        ),
      ),
    );
  }
}

class HourlyWeatherCard extends StatelessWidget {
  final WeatherData hourlyForecast;

  const HourlyWeatherCard({required this.hourlyForecast});

  @override
  Widget build(BuildContext context) {
    final formattedHourString = DateFormat.Hm().format(hourlyForecast.dateTime);
    return Container(
      width: 75,
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(formattedHourString),
          CachedNetworkImage(
            imageUrl: hourlyForecast.conditions.first.icon.toWeatherIconURL(),
            height: 45,
          ),
          Text('${hourlyForecast.temperature.day.toStringAsFixed(0)}°'),
        ],
      ),
    );
  }
}
