import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';
import 'features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';
import 'router.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => di.locator<WeatherBloc>(),
        ),
        BlocProvider(
          create: (context) => di.locator<CitySearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'NeoWeather',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: PagePaths.home,
      ),
    );
  }
}
