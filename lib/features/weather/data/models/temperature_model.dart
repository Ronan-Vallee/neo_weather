import '../../domain/entities/temperature.dart';

class TemperatureModel extends Temperature {
  const TemperatureModel({
    required super.day,
    super.morning,
    super.evening,
    super.night,
    super.min,
    super.max,
  });

  factory TemperatureModel.fromJson(Map<String, dynamic> json) {
    return TemperatureModel(
      day: (json['day'] is int)
          ? (json['day'] as int).toDouble()
          : (json['day'] as double),
      morning: json['morn'] != null
          ? (json['morn'] is int)
              ? (json['morn'] as int).toDouble()
              : (json['morn'] as double)
          : null,
      evening: json['eve'] != null
          ? (json['eve'] is int)
              ? (json['eve'] as int).toDouble()
              : (json['eve'] as double)
          : null,
      night: json['night'] != null
          ? (json['night'] is int)
              ? (json['night'] as int).toDouble()
              : (json['night'] as double)
          : null,
      min: json['min'] != null
          ? (json['min'] is int)
              ? (json['min'] as int).toDouble()
              : (json['min'] as double)
          : null,
      max: json['max'] != null
          ? (json['max'] is int)
              ? (json['max'] as int).toDouble()
              : (json['max'] as double)
          : null,
    );
  }
}
