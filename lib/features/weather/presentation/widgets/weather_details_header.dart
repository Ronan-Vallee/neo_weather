import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../router.dart';
import '../../../city/domain/entities/city.dart';

class WeatherDetailsHeader extends StatelessWidget {
  final City city;

  const WeatherDetailsHeader({required this.city});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BackButton(),
                _CityWidget(city: city),
                const _SearchCityButton(),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchCityButton extends StatelessWidget {
  const _SearchCityButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(
        context,
        PagePaths.citySearch,
      ),
      icon: Transform.flip(
        flipX: true,
        child: const Icon(Icons.search_rounded),
      ),
    );
  }
}

class _CityWidget extends StatelessWidget {
  const _CityWidget({required this.city});

  final City city;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          city.name,
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          city.state ?? city.country,
          style: textTheme.bodySmall?.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
