part of 'city_search_bloc.dart';

enum CitySearchStatus { initial, loading, loaded, failure }

class CitySearchState extends Equatable {
  final CitySearchStatus status;
  final List<City> citySearchResults;
  final Failure? failure;

  factory CitySearchState.initialState() {
    return const CitySearchState(
      status: CitySearchStatus.initial,
      citySearchResults: [],
    );
  }

  const CitySearchState({
    required this.status,
    required this.citySearchResults,
    this.failure,
  });

  CitySearchState copyWith({
    CitySearchStatus? status,
    List<City>? citySearchResults,
    Failure? failure,
  }) {
    return CitySearchState(
      status: status ?? this.status,
      citySearchResults: citySearchResults ?? this.citySearchResults,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [status, citySearchResults, failure];
}
