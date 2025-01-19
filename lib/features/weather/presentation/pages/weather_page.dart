import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../router.dart';
import '../blocs/weather_bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
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
          ],
        ),
      ),
    );
  }
}
