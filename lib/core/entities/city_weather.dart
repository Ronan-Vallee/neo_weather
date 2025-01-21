import 'package:equatable/equatable.dart';
import 'package:neo_weather/features/city/domain/entities/city.dart';
import 'package:neo_weather/features/weather/domain/entities/weather.dart';

class CityWeather extends Equatable {
  final City city;
  final Weather weather;

  const CityWeather({
    required this.city,
    required this.weather,
  });

  @override
  List<Object?> get props => [city, weather];
}
