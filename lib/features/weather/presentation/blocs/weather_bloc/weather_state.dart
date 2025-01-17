part of 'weather_bloc.dart';

enum WeatherStatus { initial, loading, loaded, failure }

class WeatherState extends Equatable {
  final WeatherStatus status;

  factory WeatherState.initialState() {
    return const WeatherState(status: WeatherStatus.initial);
  }

  const WeatherState({required this.status});

  WeatherState copyWith({WeatherStatus? status}) {
    return WeatherState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
