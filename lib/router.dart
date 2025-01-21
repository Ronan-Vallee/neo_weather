import 'package:flutter/material.dart';
import 'package:neo_weather/core/entities/city_weather.dart';
import 'package:neo_weather/features/weather/presentation/pages/weather_details_page.dart';

import 'features/city/presentation/pages/city_search_page.dart';
import 'features/weather/presentation/pages/home_page.dart';

class PagePaths {
  static const String home = '/';
  static const String citySearch = '/citySearch';
  static const String weatherDetails = '/weatherDetails';
}

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagePaths.home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case PagePaths.citySearch:
        return MaterialPageRoute(builder: (_) => const CitySearchPage());
      case PagePaths.weatherDetails:
        {
          return PageRouteBuilder(
            pageBuilder: (_, __, ___) => WeatherDetailPage(
              cityWeather: settings.arguments as CityWeather,
            ),
            transitionsBuilder: (_, animation, __, child) => SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOutCubic)),
              ),
              child: child,
            ),
          );
        }
    }
    throw UnsupportedError('Unknown route: ${settings.name}');
  }
}
