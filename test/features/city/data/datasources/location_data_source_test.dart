import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/features/city/data/datasources/location_data_source.dart';

import '../../../../mocks/mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late LocationDataSource dataSource;
  late MockLocationService mockLocationService;

  setUp(() {
    mockLocationService = MockLocationService();
    dataSource = LocationDataSource(locationService: mockLocationService);
  });

  group('getCurrentLocation', () {
    test(
      'should return Position when the call to locationService is successful.',
      () async {
        // arrange
        when(() => mockLocationService.getCurrentLocation())
            .thenAnswer((_) async => tPosition);

        // act
        final result = await dataSource.getCurrentLocation();

        // assert
        expect(result, tPosition);
        verify(() => mockLocationService.getCurrentLocation()).called(1);
      },
    );

    test(
      'should throw an exception when the call to locationService is unsuccessful.',
      () async {
        // arrange
        when(() => mockLocationService.getCurrentLocation())
            .thenThrow(LocationException());

        // act
        final call = dataSource.getCurrentLocation;

        // assert
        expect(() => call(), throwsA(isA<LocationException>()));
        verify(() => mockLocationService.getCurrentLocation()).called(1);
      },
    );
  });
}
