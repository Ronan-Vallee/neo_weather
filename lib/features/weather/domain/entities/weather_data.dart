import 'package:equatable/equatable.dart';
import 'package:neo_weather/features/weather/domain/entities/temperature.dart';
import 'package:neo_weather/features/weather/domain/entities/weather_condition.dart';

class WeatherData extends Equatable {
  const WeatherData({
    required this.dateTime,
    required this.sunrise,
    required this.sunset,
    required this.temperature,
    required this.perceivedTemperature,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uVIndex,
    required this.cloudiness,
    required this.visibility,
    required this.windSpeed,
    required this.windGust,
    required this.windDirection,
    required this.pop,
    required this.rain,
    required this.snow,
    required this.conditions,
  });

  final DateTime dateTime;
  final DateTime? sunrise;
  final DateTime? sunset;
  final Temperature temperature;
  final Temperature perceivedTemperature;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uVIndex;
  final int cloudiness;
  final int? visibility;
  final double windSpeed;
  final double? windGust;
  final int windDirection;
  final double? pop;
  final double? rain;
  final double? snow;
  final List<WeatherCondition> conditions;

  @override
  List<Object?> get props => [
        dateTime,
        sunrise,
        sunset,
        temperature,
        perceivedTemperature,
        pressure,
        humidity,
        dewPoint,
        uVIndex,
        cloudiness,
        visibility,
        windSpeed,
        windGust,
        windDirection,
        pop,
        rain,
        snow,
        conditions,
      ];
}
