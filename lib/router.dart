import 'package:flutter/material.dart';

import 'features/city/presentation/pages/city_search_page.dart';
import 'features/weather/presentation/pages/weather_page.dart';

class PagePaths {
  static const String home = '/';
  static const String citySearch = '/citySearch';
}

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagePaths.home:
        return MaterialPageRoute(builder: (_) => const WeatherPage());
      case PagePaths.citySearch:
        return MaterialPageRoute(builder: (_) => const CitySearchPage());
    }
    throw UnsupportedError('Unknown route: ${settings.name}');
  }
}
