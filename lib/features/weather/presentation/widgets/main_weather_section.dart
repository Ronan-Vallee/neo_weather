import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/weather.dart';

class MainWeatherSection extends StatelessWidget {
  final Weather weather;

  const MainWeatherSection({required this.weather});

  @override
  Widget build(BuildContext context) {
    final dateString = DateFormat.MMMMEEEEd().format(DateTime.now());
    return Column(
      spacing: 20,
      children: [
        Column(
          children: [
            _WeatherIcon(weather: weather),
            _DayTemperature(weather: weather),
            _WeatherDescription(weather: weather),
            _FormattedDate(dateString: dateString),
          ],
        ),
      ],
    );
  }
}

class _WeatherIcon extends StatelessWidget {
  const _WeatherIcon({
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: weather.current.conditions.first.icon.toWeatherIconURL(),
    );
  }
}

class _DayTemperature extends StatelessWidget {
  const _DayTemperature({
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Text(
      ' ${weather.current.temperature.day.toStringAsFixed(0)}°',
      style: const TextStyle(
        fontSize: 72,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _WeatherDescription extends StatelessWidget {
  const _WeatherDescription({
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Text(
      toBeginningOfSentenceCase(
        weather.current.conditions.first.description,
      ),
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }
}

class _FormattedDate extends StatelessWidget {
  const _FormattedDate({
    required this.dateString,
  });

  final String dateString;

  @override
  Widget build(BuildContext context) {
    return Text(
      toBeginningOfSentenceCase(dateString),
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
    );
  }
}
