import 'package:flutter_test/flutter_test.dart';
import 'package:neo_weather/features/weather/data/models/weather_condition_model.dart';

import '../../test_models/weather_models.dart';

void main() {
  test('should return a valid WeatherConditionModel from JSON.', () {
    // act
    final result = WeatherConditionModel.fromJson(tWeatherConditionModelJSON);

    // assert
    expect(result.id, 803);
    expect(result.main, "Clouds");
    expect(result.description, "nuageux");
    expect(result.icon, "04n");
  });
}
