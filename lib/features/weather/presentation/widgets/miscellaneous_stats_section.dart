import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/weather_data.dart';

class MiscellaneousStatsSection extends StatelessWidget {
  const MiscellaneousStatsSection({required this.data});

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingLarge,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(
          AppDimensions.cornerRadiusLarge,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _WeatherStat(
            value: '${data.uVIndex}',
            label: 'indice UV',
          ),
          _WeatherStat(
            value: '${data.pressure} hPa',
            label: 'Pression',
          ),
          _WeatherStat(
            value: '${data.cloudiness}%',
            label: 'Nuages',
          ),
        ],
      ),
    );
  }
}

class _WeatherStat extends StatelessWidget {
  final String value;
  final String label;

  const _WeatherStat({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
