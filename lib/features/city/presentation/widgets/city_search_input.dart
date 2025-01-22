import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../blocs/city_search_bloc/city_search_bloc.dart';

class CitySearchInput extends StatelessWidget {
  const CitySearchInput();

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.textPrimary,
      decoration: InputDecoration(
        labelText: "Rechercher une ville",
        labelStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
            ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.cornerRadiusLarge),
          ),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppDimensions.cornerRadiusLarge),
          ),
          borderSide: BorderSide(color: AppColors.secondary),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.my_location_rounded),
          onPressed: () => _onPressed(context),
        ),
      ),
      onTapOutside: (event) => _onTapOutside(),
      onSubmitted: (value) => _onSubmitted(context, value),
    );
  }

  void _onPressed(BuildContext context) {
    context.read<CitySearchBloc>().add(const CitySearchFromLocationRequested());
  }

  void _onSubmitted(BuildContext context, String value) {
    context.read<CitySearchBloc>().add(CitySearchSubmitted(query: value));
  }

  void _onTapOutside() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
