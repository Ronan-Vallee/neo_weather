import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/weather_data.dart';

class SunTimingSection extends StatelessWidget {
  const SunTimingSection({
    super.key,
    required this.data,
  });

  final WeatherData data;

  @override
  Widget build(BuildContext context) {
    if (data.sunrise == null && data.sunset == null) {
      return const SizedBox.shrink();
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
        vertical: AppDimensions.paddingRegular,
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
          _SunTimingWidget(
            dateTime: data.sunrise!,
            isRising: true,
          ),
          _SunTimingWidget(
            dateTime: data.sunset!,
            isRising: false,
          ),
        ],
      ),
    );
  }
}

class _SunTimingWidget extends StatelessWidget {
  final DateTime dateTime;
  final bool isRising;

  const _SunTimingWidget({
    required this.dateTime,
    required this.isRising,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      spacing: AppDimensions.paddingMedium,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isRising
                  ? Icons.arrow_upward_rounded
                  : Icons.arrow_downward_rounded,
              color: Colors.cyan,
              size: 18,
            ),
            const Icon(Icons.sunny, color: Colors.orange, size: 24),
          ],
        ),
        Column(
          children: [
            Text(
              isRising ? 'Lever' : 'Coucher',
              style: textTheme.bodyMedium
                  ?.copyWith(color: AppColors.textSecondary),
            ),
            Text(
              DateFormat.Hm().format(dateTime),
              style: textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
