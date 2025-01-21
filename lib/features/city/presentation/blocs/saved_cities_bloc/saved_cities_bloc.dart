import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/entities/city_weather.dart';
import '../../../../../core/errors/failures.dart';
import '../../../../../core/interfaces/usecase.dart';
import '../../../domain/entities/city.dart';
import '../../../domain/usecases/get_saved_cities_weather.dart';
import '../../../domain/usecases/remove_city.dart';
import '../../../domain/usecases/save_city.dart';

part 'saved_cities_event.dart';
part 'saved_cities_state.dart';

class SavedCitiesBloc extends Bloc<SavedCitiesEvent, SavedCitiesState> {
  final GetSavedCitiesWeather getSavedCitiesUsecase;
  final SaveCity saveCityUsecase;
  final RemoveCity removeCityUsecase;

  SavedCitiesBloc({
    required this.getSavedCitiesUsecase,
    required this.saveCityUsecase,
    required this.removeCityUsecase,
  }) : super(SavedCitiesState.initialState()) {
    on<SavedCitiesRequested>(_onCitiesRequested);
    on<SavedCitiesCitySelected>(_onCitySelected);
    on<SavedCitiesCityDismissed>(_onCityDismissed);
  }

  Future<void> _onCitiesRequested(
    SavedCitiesRequested event,
    Emitter<SavedCitiesState> emit,
  ) async {
    emit(state.copyWith(status: SavedCitiesStatus.loading));
    final result = await getSavedCitiesUsecase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SavedCitiesStatus.failure,
          failure: failure,
        ),
      ),
      (cityWeather) => emit(
        state.copyWith(
          status: SavedCitiesStatus.loaded,
          cityWeatherList: cityWeather,
        ),
      ),
    );
  }

  Future<void> _onCitySelected(
    SavedCitiesCitySelected event,
    Emitter<SavedCitiesState> emit,
  ) async {
    emit(state.copyWith(status: SavedCitiesStatus.loading));
    final result = await saveCityUsecase(SaveCityParams(city: event.city));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SavedCitiesStatus.failure,
          failure: failure,
        ),
      ),
      (_) => add(const SavedCitiesRequested()),
    );
  }

  Future<void> _onCityDismissed(
    SavedCitiesCityDismissed event,
    Emitter<SavedCitiesState> emit,
  ) async {
    emit(state.copyWith(status: SavedCitiesStatus.loading));
    final result = await removeCityUsecase(RemoveCityParams(city: event.city));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: SavedCitiesStatus.failure,
          failure: failure,
        ),
      ),
      (_) => add(const SavedCitiesRequested()),
    );
  }
}
