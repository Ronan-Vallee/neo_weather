import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/weather_data.dart';

class DailyForecastSection extends StatelessWidget {
  final List<WeatherData> dailyForecast;

  const DailyForecastSection({required this.dailyForecast});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusLarge),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(AppDimensions.paddingRegular),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dailyForecast.length,
          itemBuilder: (context, index) {
            final day = dailyForecast[index];
            if (day.temperature.min == null || day.temperature.max == null) {
              return const SizedBox.shrink();
            }
            return WeatherDayItem(
              day: DateFormat.EEEE().format(day.dateTime),
              description: day.conditions.first.description,
              minTemperature: day.temperature.min,
              maxTemperature: day.temperature.max,
              icon: day.conditions.first.icon,
            );
          },
        ),
      ),
    );
  }
}

class WeatherDayItem extends StatelessWidget {
  final String day;
  final String description;
  final double? minTemperature;
  final double? maxTemperature;
  final String icon;

  const WeatherDayItem({
    required this.day,
    required this.description,
    required this.minTemperature,
    required this.maxTemperature,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: AppDimensions.paddingMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 3,
            child: Text(toBeginningOfSentenceCase(day)),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: AppDimensions.paddingSmall,
              children: [
                CachedNetworkImage(
                  imageUrl: icon.toWeatherIconURL(),
                  height: 32,
                ),
                Expanded(
                  child: Text(
                    toBeginningOfSentenceCase(description),
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
              ],
            ),
          ),
          if (minTemperature != null && maxTemperature != null)
            Expanded(
              flex: 2,
              child: Text(
                '${minTemperature!.toStringAsFixed(0)}° / ${maxTemperature!.toStringAsFixed(0)}°',
                textAlign: TextAlign.right,
              ),
            ),
        ],
      ),
    );
  }
}
