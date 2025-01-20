part of 'saved_cities_bloc.dart';

abstract class SavedCitiesEvent extends Equatable {
  const SavedCitiesEvent();

  @override
  List<Object> get props => [];
}

class SavedCitiesRequested extends SavedCitiesEvent {
  const SavedCitiesRequested();

  @override
  List<Object> get props => [];
}

class SavedCitiesCitySelected extends SavedCitiesEvent {
  final City city;

  const SavedCitiesCitySelected({required this.city});

  @override
  List<Object> get props => [city];
}

class SavedCitiesCityDismissed extends SavedCitiesEvent {
  final City city;

  const SavedCitiesCityDismissed({required this.city});

  @override
  List<Object> get props => [city];
}
