import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/interfaces/usecase.dart';
import 'package:neo_weather/features/city/domain/usecases/get_saved_cities.dart';
import 'package:neo_weather/features/city/domain/usecases/remove_city.dart';
import 'package:neo_weather/features/city/domain/usecases/save_city.dart';
import 'package:neo_weather/features/city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';

import '../../../mocks/city_mocks.dart';
import '../../../test_models/city_models.dart';

void main() {
  late SavedCitiesBloc bloc;
  late MockGetSavedCities mockGetSavedCities;
  late MockSaveCity mockSaveCity;
  late MockRemoveCity mockRemoveCity;

  setUp(() {
    mockGetSavedCities = MockGetSavedCities();
    mockSaveCity = MockSaveCity();
    mockRemoveCity = MockRemoveCity();
    bloc = SavedCitiesBloc(
      getSavedCitiesUsecase: mockGetSavedCities,
      saveCityUsecase: mockSaveCity,
      removeCityUsecase: mockRemoveCity,
    );

    registerFallbackValue(NoParams());
  });

  test('initial state should be SavedCitiesState.initialState().', () {
    expect(bloc.state, SavedCitiesState.initialState());
  });

  group('on SavedCitiesRequested', () {
    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then loaded with the received city list when '
      'getSavedCitiesUsecase is successful.',
      setUp: () => when(() => mockGetSavedCities(any()))
          .thenAnswer((_) async => const Right(tCityList)),
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesRequested()),
      expect: () => [
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loading,
        ),
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loaded,
          cities: tCityList,
        ),
      ],
      verify: (_) => verify(() => mockGetSavedCities(NoParams())).called(1),
    );

    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then failure with the received failure when '
      'getSavedCitiesUsecase fails.',
      setUp: () => when(() => mockGetSavedCities(any()))
          .thenAnswer((_) async => const Left(GetSavedCitiesFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesRequested()),
      expect: () => [
        SavedCitiesState.initialState()
            .copyWith(status: SavedCitiesStatus.loading),
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.failure,
          failure: const GetSavedCitiesFailure(),
        ),
      ],
      verify: (_) => verify(() => mockGetSavedCities(NoParams())).called(1),
    );
  });

  group('on SavedCitiesCitySelected', () {
    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then trigger the SavedCitiesRequested event when '
      'saveCityUsecase is successful.',
      setUp: () {
        when(() => mockSaveCity(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => mockGetSavedCities(any()))
            .thenAnswer((_) async => const Right(tCityList));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesCitySelected(city: tCity)),
      expect: () => [
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loading,
        ),
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loaded,
          cities: tCityList,
        ),
      ],
      verify: (_) {
        verify(() => mockSaveCity(const SaveCityParams(city: tCity))).called(1);
        verify(() => mockGetSavedCities(NoParams())).called(1);
      },
    );

    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then failure with the received failure when '
      'saveCityUsecase fails.',
      setUp: () => when(() => mockSaveCity(any()))
          .thenAnswer((_) async => const Left(SaveCityFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesCitySelected(city: tCity)),
      expect: () => [
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loading,
        ),
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.failure,
          failure: const SaveCityFailure(),
        ),
      ],
      verify: (_) =>
          verify(() => mockSaveCity(const SaveCityParams(city: tCity)))
              .called(1),
    );
  });

  group('on SavedCitiesCityDismissed', () {
    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then trigger the SavedCitiesRequested event when '
      'removeCityUsecase is successful.',
      setUp: () {
        when(() => mockRemoveCity(any()))
            .thenAnswer((_) async => const Right(unit));
        when(() => mockGetSavedCities(any()))
            .thenAnswer((_) async => const Right(tCityList));
      },
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesCityDismissed(city: tCity)),
      expect: () => [
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loading,
        ),
        bloc.state.copyWith(
          status: SavedCitiesStatus.loaded,
          cities: tCityList,
        ),
      ],
      verify: (_) {
        verify(() => mockRemoveCity(const RemoveCityParams(city: tCity)))
            .called(1);
        verify(() => mockGetSavedCities(NoParams())).called(1);
      },
    );

    blocTest<SavedCitiesBloc, SavedCitiesState>(
      'should emit loading then failure with the received falure when '
      'removeCityUsecase fails.',
      setUp: () => when(() => mockRemoveCity(any()))
          .thenAnswer((_) async => const Left(RemoveCityFailure())),
      build: () => bloc,
      act: (bloc) => bloc.add(const SavedCitiesCityDismissed(city: tCity)),
      expect: () => [
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.loading,
        ),
        SavedCitiesState.initialState().copyWith(
          status: SavedCitiesStatus.failure,
          failure: const RemoveCityFailure(),
        ),
      ],
      verify: (_) =>
          verify(() => mockRemoveCity(const RemoveCityParams(city: tCity)))
              .called(1),
    );
  });
}
