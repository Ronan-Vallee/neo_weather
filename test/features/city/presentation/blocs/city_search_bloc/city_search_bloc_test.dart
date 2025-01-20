import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';
import 'package:neo_weather/features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';

import '../../../mocks/city_mocks.dart';
import '../../../test_models/city_models.dart';

void main() {
  late CitySearchBloc bloc;
  late MockSearch mockSearch;

  setUp(() {
    mockSearch = MockSearch();
    bloc = CitySearchBloc(searchUsecase: mockSearch);
  });

  const tCityToSearch = 'Paris';

  test('initial state should be CitySearchState.initialState()', () {
    expect(bloc.state, CitySearchState.initialState());
  });

  blocTest<CitySearchBloc, CitySearchState>(
    'should emit loading then loaded with the received city list when '
    'data is gotten successfully.',
    build: () {
      when(() => mockSearch(any()))
          .thenAnswer((_) async => const Right(tCityList));
      return bloc;
    },
    act: (bloc) => bloc.add(const CitySearchSubmitted(query: tCityToSearch)),
    expect: () => [
      CitySearchState.initialState().copyWith(status: CitySearchStatus.loading),
      CitySearchState.initialState().copyWith(
        status: CitySearchStatus.loaded,
        citySearchResults: tCityList,
      ),
    ],
    verify: (_) {
      verify(() => mockSearch(const SearchParams(cityToSearch: tCityToSearch)))
          .called(1);
    },
  );

  blocTest<CitySearchBloc, CitySearchState>(
    'should emit loading then failure with the received failure '
    'when getting data fails.',
    setUp: () {
      when(() => mockSearch(any()))
          .thenAnswer((_) async => const Left(SearchFailure()));
    },
    build: () => bloc,
    act: (bloc) => bloc.add(const CitySearchSubmitted(query: tCityToSearch)),
    expect: () => [
      CitySearchState.initialState().copyWith(status: CitySearchStatus.loading),
      CitySearchState.initialState().copyWith(
        status: CitySearchStatus.failure,
        failure: const SearchFailure(),
      ),
    ],
    verify: (_) {
      verify(() => mockSearch(const SearchParams(cityToSearch: tCityToSearch)))
          .called(1);
    },
  );
}
