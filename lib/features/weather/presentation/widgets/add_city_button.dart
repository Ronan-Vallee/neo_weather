import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../router.dart';

class AddCityButton extends StatelessWidget {
  final bool isCityListEmpty;

  const AddCityButton({required this.isCityListEmpty});

  @override
  Widget build(BuildContext context) {
    if (isCityListEmpty) {
      return const _LargeAddCityButton();
    }
    return const _SmallAddCityButton();
  }
}

class _LargeAddCityButton extends StatelessWidget {
  const _LargeAddCityButton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingSmall),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusLarge),
        onTap: () => Navigator.of(context).pushNamed(PagePaths.citySearch),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingLarge,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.cornerRadiusLarge,
            ),
            border: Border.all(color: AppColors.textPrimary),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppDimensions.paddingSmall,
            children: [
              const Icon(Icons.add_circle_outline_outlined),
              Text(
                'Ajouter une ville',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SmallAddCityButton extends StatelessWidget {
  const _SmallAddCityButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: AppDimensions.paddingRegular),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusLarge),
        onTap: () => Navigator.of(context).pushNamed(PagePaths.citySearch),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMedium,
            vertical: AppDimensions.paddingMedium,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              AppDimensions.cornerRadiusLarge,
            ),
            border: Border.all(color: AppColors.secondary),
          ),
          child: const Icon(Icons.add_rounded, color: AppColors.secondary),
        ),
      ),
    );
  }
}
