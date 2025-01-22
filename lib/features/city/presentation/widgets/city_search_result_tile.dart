import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../domain/entities/city.dart';
import '../blocs/saved_cities_bloc/saved_cities_bloc.dart';

class CitySearchResultTile extends StatelessWidget {
  final City city;

  const CitySearchResultTile({required this.city});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.cornerRadiusSmall),
      ),
      title: Text(city.name),
      trailing: Text(
        "${city.country}${city.state != null ? ', ${city.state}' : ''}",
      ),
      onTap: () => _onTap(context),
    );
  }

  void _onTap(BuildContext context) {
    return context
        .read<SavedCitiesBloc>()
        .add(SavedCitiesCitySelected(city: city));
  }
}
