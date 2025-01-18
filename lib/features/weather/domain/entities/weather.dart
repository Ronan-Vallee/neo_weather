import 'package:equatable/equatable.dart';

import 'weather_data.dart';

class Weather extends Equatable {
  final double latitude;
  final double longitude;
  final String timezone;
  final int timezoneOffset;
  final WeatherData current;
  final List<WeatherData> hourly;
  final List<WeatherData> daily;

  const Weather({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  @override
  List<Object?> get props => [
        latitude,
        longitude,
        timezone,
        timezoneOffset,
        current,
        hourly,
        daily,
      ];
}
