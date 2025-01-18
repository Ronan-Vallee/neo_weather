import 'package:neo_weather/features/weather/data/models/temperature_model.dart';

import '../../domain/entities/weather_data.dart';
import 'weather_condition_model.dart';

class WeatherDataModel extends WeatherData {
  const WeatherDataModel({
    required super.dateTime,
    super.sunrise,
    super.sunset,
    required super.temperature,
    required super.perceivedTemperature,
    required super.pressure,
    required super.humidity,
    required super.dewPoint,
    required super.uVIndex,
    required super.cloudiness,
    super.visibility,
    required super.windSpeed,
    super.windGust,
    required super.windDirection,
    super.pop,
    super.rain,
    super.snow,
    required super.conditions,
  });

  static DateTime _fromTimestamp(int timestamp) =>
      DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);

  factory WeatherDataModel.fromJson(Map<String, dynamic> json) {
    final temperature = TemperatureModel.fromJson(
      (json['temp'] is Map) ? json['temp'] : {'day': json['temp']},
    );
    final perceivedTemperature = TemperatureModel.fromJson(
      (json['feels_like'] is Map)
          ? json['feels_like']
          : {'day': json['feels_like']},
    );

    return WeatherDataModel(
      dateTime: _fromTimestamp(json['dt'] as int),
      sunrise: json['sunrise'] != null
          ? _fromTimestamp(json['sunrise'] as int)
          : null,
      sunset:
          json['sunset'] != null ? _fromTimestamp(json['sunset'] as int) : null,
      temperature: temperature,
      perceivedTemperature: perceivedTemperature,
      pressure: json['pressure'] as int,
      humidity: json['humidity'] as int,
      dewPoint: (json['dew_point'] is int)
          ? (json['dew_point'] as int).toDouble()
          : (json['dew_point'] as double),
      uVIndex: (json['uvi'] is int)
          ? (json['uvi'] as int).toDouble()
          : (json['uvi'] as double),
      cloudiness: json['clouds'] as int,
      visibility: json['visibility'] != null ? json['visibility'] as int : null,
      windSpeed: (json['wind_speed'] is int)
          ? (json['wind_speed'] as int).toDouble()
          : (json['wind_speed'] as double),
      windGust: json['wind_gust'] != null
          ? (json['wind_gust'] is int)
              ? (json['wind_gust'] as int).toDouble()
              : (json['wind_gust'] as double)
          : null,
      windDirection: json['wind_deg'] as int,
      pop: json['pop'] != null
          ? (json['pop'] is int)
              ? (json['pop'] as int).toDouble()
              : (json['pop'] as double)
          : null,
      rain: json['rain'] != null ? json['rain'] as double : null,
      snow: json['snow'] != null ? json['snow'] as double : null,
      conditions: (json['weather'] as List<dynamic>)
          .map<WeatherConditionModel>((e) => WeatherConditionModel.fromJson(e))
          .toList(),
    );
  }
}
