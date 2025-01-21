import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router.dart';
import '../../../city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';
import '../blocs/weather_bloc/weather_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(PagePaths.citySearch),
              child: const Text("Search city"),
            ),
            OutlinedButton(
              onPressed: () =>
                  context.read<WeatherBloc>().add(const WeatherRequested()),
              child: const Text("Fetch Weather"),
            ),
            Expanded(
              child: BlocBuilder<SavedCitiesBloc, SavedCitiesState>(
                buildWhen: (previous, current) =>
                    current.status == SavedCitiesStatus.loaded,
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.cityWeatherList.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ValueKey<String>(
                            state.cityWeatherList[index].city.name),
                        onDismissed: (direction) => context
                            .read<SavedCitiesBloc>()
                            .add(SavedCitiesCityDismissed(
                              city: state.cityWeatherList[index].city,
                            )),
                        child: ListTile(
                          leading: Text(state.cityWeatherList[index].weather
                              .current.temperature.day
                              .toString()),
                          title: Text(state.cityWeatherList[index].city.name),
                          trailing: Text(
                            "${state.cityWeatherList[index].city.country}, ${state.cityWeatherList[index].city.state}",
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
