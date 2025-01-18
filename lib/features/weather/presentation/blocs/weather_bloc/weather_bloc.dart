import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/get_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeather getWeatherUsecase;

  WeatherBloc({required this.getWeatherUsecase})
      : super(WeatherState.initialState()) {
    on<WeatherRequested>(_onWeatherRequested);
  }

  Future<void> _onWeatherRequested(
    WeatherRequested event,
    Emitter<WeatherState> emit,
  ) async {
    final result = await getWeatherUsecase(
      const GetWeatherParams(latitude: 48.858, longitude: 3.294),
    );
  }
}
