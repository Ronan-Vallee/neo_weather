import 'package:neo_weather/features/city/data/models/city_model.dart';

const tCity = tCityModel;

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
