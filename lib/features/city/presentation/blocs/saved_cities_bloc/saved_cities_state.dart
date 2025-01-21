part of 'saved_cities_bloc.dart';

enum SavedCitiesStatus { initial, loading, loaded, failure }

class SavedCitiesState extends Equatable {
  final SavedCitiesStatus status;
  final List<CityWeather> cityWeatherList;
  final Failure? failure;

  factory SavedCitiesState.initialState() {
    return const SavedCitiesState(
      status: SavedCitiesStatus.initial,
      cityWeatherList: [],
    );
  }

  const SavedCitiesState({
    required this.status,
    required this.cityWeatherList,
    this.failure,
  });

  SavedCitiesState copyWith({
    SavedCitiesStatus? status,
    List<CityWeather>? cityWeatherList,
    Failure? failure,
  }) {
    return SavedCitiesState(
      status: status ?? this.status,
      cityWeatherList: cityWeatherList ?? this.cityWeatherList,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, cityWeatherList, failure];
}
