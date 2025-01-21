import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/core/interfaces/usecase.dart';
import 'package:neo_weather/features/city/domain/usecases/search_from_location.dart';

import '../../../domain/entities/city.dart';
import '../../../domain/usecases/search.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final Search searchUsecase;
  final SearchFromLocation searchFromLocationUsecase;

  CitySearchBloc({
    required this.searchUsecase,
    required this.searchFromLocationUsecase,
  }) : super(CitySearchState.initialState()) {
    on<CitySearchSubmitted>(_onCitySearchSubmitted);
    on<CitySearchFromLocationRequested>(_onSearchFromLocationRequested);
  }

  Future<void> _onCitySearchSubmitted(
    CitySearchSubmitted event,
    Emitter<CitySearchState> emit,
  ) async {
    emit(state.copyWith(status: CitySearchStatus.loading));
    final result = await searchUsecase(SearchParams(cityToSearch: event.query));

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CitySearchStatus.failure,
          failure: failure,
        ),
      ),
      (cities) => emit(
        state.copyWith(
          status: CitySearchStatus.loaded,
          citySearchResults: cities,
        ),
      ),
    );
  }

  Future<void> _onSearchFromLocationRequested(
    CitySearchFromLocationRequested event,
    Emitter<CitySearchState> emit,
  ) async {
    emit(state.copyWith(status: CitySearchStatus.loading));
    final result = await searchFromLocationUsecase(NoParams());

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: CitySearchStatus.failure,
          failure: failure,
        ),
      ),
      (cities) => emit(
        state.copyWith(
          status: CitySearchStatus.loaded,
          citySearchResults: cities,
        ),
      ),
    );
  }
}
