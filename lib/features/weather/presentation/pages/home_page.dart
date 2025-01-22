import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';
import '../widgets/add_city_button.dart';
import '../widgets/city_weather_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return _SavedCitiesFailureListener(
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<SavedCitiesBloc, SavedCitiesState>(
            buildWhen: (previous, current) =>
                current.status == SavedCitiesStatus.loaded,
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.all(AppDimensions.paddingRegular),
                itemCount: state.cityWeatherList.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.cityWeatherList.length) {
                    return AddCityButton(
                      isCityListEmpty: state.cityWeatherList.isEmpty,
                    );
                  }
                  return CityWeatherTile(
                    cityWeather: state.cityWeatherList[index],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SavedCitiesFailureListener
    extends BlocListener<SavedCitiesBloc, SavedCitiesState> {
  _SavedCitiesFailureListener({super.child})
      : super(
          listenWhen: (previous, current) {
            return current.status == SavedCitiesStatus.failure;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure?.errorMessage ?? 'Erreur inconnue'),
              ),
            );
          },
        );
}
