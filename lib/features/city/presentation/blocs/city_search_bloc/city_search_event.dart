part of 'city_search_bloc.dart';

abstract class CitySearchEvent extends Equatable {
  const CitySearchEvent();

  @override
  List<Object> get props => [];
}

class CitySearchSubmitted extends CitySearchEvent {
  final String query;

  const CitySearchSubmitted({required this.query});

  @override
  List<Object> get props => [query];
}
