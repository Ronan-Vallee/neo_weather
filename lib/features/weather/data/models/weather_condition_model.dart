import '../../domain/entities/weather_condition.dart';

class WeatherConditionModel extends WeatherCondition {
  const WeatherConditionModel({
    required super.id,
    required super.main,
    required super.description,
    required super.icon,
  });

  factory WeatherConditionModel.fromJson(Map<String, dynamic> json) {
    return WeatherConditionModel(
      id: json['id'] as int,
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );
  }

  @override
  List<Object?> get props => [id, main, description, icon];
}
