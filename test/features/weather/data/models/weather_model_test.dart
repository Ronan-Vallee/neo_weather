import 'package:flutter_test/flutter_test.dart';
import 'package:neo_weather/features/weather/data/models/weather_data_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_model.dart';

import '../../test_models/weather_models.dart';

void main() {
  test(
    'should return a valid WeatherModel from JSON.',
    () {
      // act
      final result = WeatherModel.fromJson(tWeatherModelJSON);

      // assert
      expect(result.latitude, 48.858);
      expect(result.longitude, 2.294);
      expect(result.timezone, "Etc/GMT-3");
      expect(result.timezoneOffset, 10800);
      expect(result.current, isA<WeatherDataModel>());
      expect(result.hourly, isA<List<WeatherDataModel>>());
      expect(result.daily, isA<List<WeatherDataModel>>());
    },
  );

  test(
    'should correctly parse other models.',
    () {
      // act
      final result = WeatherModel.fromJson(tWeatherModelJSON);

      // assert
      expect(result.current, tCurrentWeatherDataModel);
      expect(result.hourly.first, tHourlyWeatherDataModel);
      expect(result.daily.first, tDailyWeatherDataModel);
    },
  );
}
