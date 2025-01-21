import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neo_weather/core/theme/app_colors.dart';

import 'features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';
import 'features/city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';
import 'router.dart';
import 'service_locator.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await di.init();

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
          create: (context) => di.locator<CitySearchBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              di.locator<SavedCitiesBloc>()..add(const SavedCitiesRequested()),
        ),
      ],
      child: MaterialApp(
        title: 'NeoWeather',
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: const ColorScheme.light(
            primary: AppColors.primary,
            secondary: AppColors.secondary,
            surface: AppColors.cardBackground,
            onSurface: AppColors.textPrimary,
          ),
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: PagePaths.home,
      ),
    );
  }
}
