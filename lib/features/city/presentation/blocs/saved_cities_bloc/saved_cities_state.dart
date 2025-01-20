part of 'saved_cities_bloc.dart';

enum SavedCitiesStatus { initial, loading, loaded, failure }

class SavedCitiesState extends Equatable {
  final SavedCitiesStatus status;
  final List<City> cities;
  final Failure? failure;

  factory SavedCitiesState.initialState() {
    return const SavedCitiesState(
      status: SavedCitiesStatus.initial,
      cities: [],
    );
  }

  const SavedCitiesState({
    required this.status,
    required this.cities,
    this.failure,
  });

  SavedCitiesState copyWith({
    SavedCitiesStatus? status,
    List<City>? cities,
    Failure? failure,
  }) {
    return SavedCitiesState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, cities, failure];
}
