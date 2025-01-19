import 'package:flutter/material.dart';

import 'features/weather/presentation/pages/weather_page.dart';

class PagePaths {
  static const String home = '/';
}

class AppRouter {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagePaths.home:
        return MaterialPageRoute(builder: (_) => const WeatherPage());
    }
    throw UnsupportedError('Unknown route: ${settings.name}');
  }
}
