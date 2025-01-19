import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:neo_weather/core/errors/failures.dart';

import '../../../domain/entities/city.dart';
import '../../../domain/usecases/search.dart';

part 'city_search_event.dart';
part 'city_search_state.dart';

class CitySearchBloc extends Bloc<CitySearchEvent, CitySearchState> {
  final Search searchUsecase;

  CitySearchBloc({required this.searchUsecase})
      : super(CitySearchState.initialState()) {
    on<CitySearchSubmitted>(_onCitySearchSubmitted);
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
}
