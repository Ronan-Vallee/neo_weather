import 'package:flutter_test/flutter_test.dart';
import 'package:neo_weather/features/weather/data/models/temperature_model.dart';

import '../../test_models/weather_models.dart';

void main() {
  test('should return a valid TemperatureModel from JSON.', () {
    // act
    final result = TemperatureModel.fromJson(tTemperatureModelJSON);

    // assert
    expect(result.day, 25.44);
    expect(result.min, 25.13);
    expect(result.max, 25.46);
    expect(result.night, 25.13);
    expect(result.evening, 25.3);
    expect(result.morning, 25.3);
  });

  test('should handle null values correctly.', () {
    // arrange
    const jsonWithNulls = {
      "day": 15.0,
      "morn": null,
      "eve": null,
      "night": null,
      "min": null,
      "max": null,
    };

    // act
    final result = TemperatureModel.fromJson(jsonWithNulls);

    // assert
    expect(result.day, 15.0);
    expect(result.morning, null);
    expect(result.evening, null);
    expect(result.night, null);
    expect(result.min, null);
    expect(result.max, null);
  });
}
