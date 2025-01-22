import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/entities/city_weather.dart';
import '../../../../core/theme/app_dimensions.dart';
import '../../../../router.dart';
import '../../../city/domain/entities/city.dart';
import '../../../city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';
import 'city_weather_tile_widgets.dart';

class CityWeatherTile extends StatelessWidget {
  const CityWeatherTile({
    super.key,
    required this.cityWeather,
  });

  final CityWeather cityWeather;

  @override
  Widget build(BuildContext context) {
    final city = cityWeather.city;
    final weather = cityWeather.weather;
    return Padding(
      padding: const EdgeInsets.only(top: AppDimensions.paddingRegular),
      child: Dismissible(
        key: ValueKey<String>('${city.name}${city.state}'),
        onDismissed: (_) => _onDismissed(context, city),
        child: Material(
          borderRadius: BorderRadius.circular(
            AppDimensions.cornerRadiusSmall,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(
              AppDimensions.cornerRadiusSmall,
            ),
            onTap: () => _navigateToWeatherDetails(context, cityWeather),
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingLarge),
              child: TileContent(city: city, weather: weather),
            ),
          ),
        ),
      ),
    );
  }

  void _onDismissed(BuildContext context, City city) {
    context.read<SavedCitiesBloc>().add(SavedCitiesCityDismissed(city: city));
  }

  void _navigateToWeatherDetails(
    BuildContext context,
    CityWeather cityWeather,
  ) {
    Navigator.of(context).pushNamed(
      PagePaths.weatherDetails,
      arguments: cityWeather,
    );
  }
}
