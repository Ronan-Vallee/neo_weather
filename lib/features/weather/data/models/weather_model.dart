import '../../domain/entities/weather.dart';
import 'weather_data_model.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.latitude,
    required super.longitude,
    required super.timezone,
    required super.timezoneOffset,
    required super.current,
    required super.hourly,
    required super.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      latitude: json['lat'] as double,
      longitude: json['lon'] as double,
      timezone: json['timezone'] as String,
      timezoneOffset: json['timezone_offset'] as int,
      current:
          WeatherDataModel.fromJson(json['current'] as Map<String, dynamic>),
      hourly: (json['hourly'] as List<dynamic>)
          .map<WeatherDataModel>((e) => WeatherDataModel.fromJson(e))
          .toList(),
      daily: (json['daily'] as List<dynamic>)
          .map<WeatherDataModel>((e) => WeatherDataModel.fromJson(e))
          .toList(),
    );
  }
}
