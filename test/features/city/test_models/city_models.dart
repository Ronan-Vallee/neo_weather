import 'package:neo_weather/core/entities/city_weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:neo_weather/features/city/data/models/city_model.dart';
import 'package:neo_weather/features/city/domain/entities/city.dart';

import '../../weather/test_models/weather_models.dart';

const City tCity = tCityModel;

const List<City> tCityList = [tCity];

const tCityModel = CityModel(
  name: 'Paris',
  latitude: 48.8566,
  longitude: 2.3522,
  country: 'FR',
  state: 'Ile-de-France',
);

final Map<String, dynamic> tCityModelJSON = {
  'local_names': {'fr': 'Paris'},
  'lat': 48.8566,
  'lon': 2.3522,
  'country': 'FR',
  'state': 'Ile-de-France',
};

/// *** CityWeather models *** ///

final tCityWeather = CityWeather(
  city: tCity,
  weather: tWeather,
);

final List<CityWeather> tCityWeatherList = [tCityWeather];

/// *** Others *** ///
final tPosition = Position(
  latitude: 10.0,
  longitude: 20.0,
  timestamp: DateTime.now(),
  accuracy: 1.0,
  altitude: 1.0,
  heading: 1.0,
  speed: 1.0,
  speedAccuracy: 1.0,
  altitudeAccuracy: 1.0,
  headingAccuracy: 1.0,
);
