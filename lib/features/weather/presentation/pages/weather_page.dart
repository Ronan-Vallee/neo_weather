import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_weather/features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
          onPressed: () =>
              context.read<WeatherBloc>().add(const WeatherRequested()),
          child: const Text("Fetch Weather"),
        ),
      ),
    );
  }
}
