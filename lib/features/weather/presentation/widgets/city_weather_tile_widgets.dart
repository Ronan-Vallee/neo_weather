import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/string_extensions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../city/domain/entities/city.dart';
import '../../domain/entities/weather.dart';

class TileContent extends StatelessWidget {
  const TileContent({
    required this.city,
    required this.weather,
  });

  final City city;
  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppDimensions.paddingSmall,
          children: [
            _CityInformations(city: city),
            _WeatherDescription(weather: weather),
          ],
        ),
        Column(
          children: [
            _WeatherIcon(weather: weather),
            _Temperature(weather: weather),
          ],
        ),
      ],
    );
  }
}

class _Temperature extends StatelessWidget {
  const _Temperature({
    required this.weather,
  });

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${weather.current.temperature.day.toStringAsFixed(0)}°C',
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
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
      imageUrl: weather.current.conditions.first.icon
          .toWeatherIconURL(highResolution: true),
      height: 64.0,
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
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
    );
  }
}

class _CityInformations extends StatelessWidget {
  const _CityInformations({
    required this.city,
  });

  final City city;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Text(
          city.name,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          city.state,
          style: textTheme.bodyMedium?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
