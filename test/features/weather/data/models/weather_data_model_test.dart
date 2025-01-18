import 'package:flutter_test/flutter_test.dart';
import 'package:neo_weather/features/weather/data/models/temperature_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_condition_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_data_model.dart';

import '../../test_models/weather_models.dart';

void main() {
  test(
    'should return a valid WeatherDataModel from JSON for current day.',
    () {
      // act
      final result = WeatherDataModel.fromJson(tCurrentWeatherDataModelJSON);

      // assert
      expect(
        result.dateTime,
        DateTime.fromMillisecondsSinceEpoch(1737152323 * 1000),
      );
      expect(
        result.sunrise,
        DateTime.fromMillisecondsSinceEpoch(1737168879 * 1000),
      );
      expect(
        result.sunset,
        DateTime.fromMillisecondsSinceEpoch(1737212092 * 1000),
      );
      expect(result.temperature, isA<TemperatureModel>());
      expect(result.perceivedTemperature, isA<TemperatureModel>());
      expect(result.pressure, 1012);
      expect(result.humidity, 79);
      expect(result.dewPoint, 21.32);
      expect(result.uVIndex, 0.3);
      expect(result.cloudiness, 77);
      expect(result.visibility, 10000);
      expect(result.windSpeed, 8.84);
      expect(result.windDirection, 33);
      expect(result.windGust, 9.52);
      expect(result.rain, 1.1);
      expect(result.snow, 1.1);
      expect(result.conditions, isA<List<WeatherConditionModel>>());
      expect(result.conditions.first, isA<WeatherConditionModel>());
    },
  );

  test(
    'should return a valid WeatherDataModel from JSON for an hourly data.',
    () {
      // act
      final result = WeatherDataModel.fromJson(tHourlyWeatherDataModelJSON);

      // assert
      expect(
        result.dateTime,
        DateTime.fromMillisecondsSinceEpoch(1737151200 * 1000),
      );
      expect(
        result.temperature,
        isA<TemperatureModel>().having((e) => e.day, 'day', 25.22),
      );
      expect(
        result.perceivedTemperature,
        isA<TemperatureModel>().having((e) => e.day, 'day', 25.86),
      );
      expect(result.pressure, 1012);
      expect(result.humidity, 79);
      expect(result.dewPoint, 21.32);
      expect(result.uVIndex, 0);
      expect(result.cloudiness, 77);
      expect(result.visibility, 10000);
      expect(result.windSpeed, 8.84);
      expect(result.windDirection, 33);
      expect(result.windGust, 9.52);
      expect(result.pop, 0.5);
      expect(result.rain, 1.1);
      expect(result.snow, 1.1);
      expect(result.conditions, isA<List<WeatherConditionModel>>());
      expect(result.conditions.first, tWeatherConditionModel);
    },
  );

  test(
    'should return a valid WeatherDataModel from JSON for a daily data.',
    () {
      // act
      final result = WeatherDataModel.fromJson(tDailyWeatherDataModelJSON);

      // assert
      expect(
        result.dateTime,
        DateTime.fromMillisecondsSinceEpoch(1737187200 * 1000),
      );
      expect(
        result.sunrise,
        DateTime.fromMillisecondsSinceEpoch(1737168879 * 1000),
      );
      expect(
        result.sunset,
        DateTime.fromMillisecondsSinceEpoch(1737212092 * 1000),
      );

      expect(
        result.temperature,
        isA<TemperatureModel>()
            .having((e) => e.day, 'day', 25.44)
            .having((e) => e.min, 'min', 25.13)
            .having((e) => e.max, 'max', 25.46)
            .having((e) => e.night, 'night', 25.13)
            .having((e) => e.evening, 'evening', 25.3)
            .having((e) => e.morning, 'morning', 25.3),
      );
      expect(
        result.perceivedTemperature,
        isA<TemperatureModel>()
            .having((e) => e.day, 'day', 25.97)
            .having((e) => e.night, 'night', 25.66)
            .having((e) => e.evening, 'evening', 25.82)
            .having((e) => e.morning, 'morning', 25.9),
      );
      expect(result.pressure, 1012);
      expect(result.humidity, 74);
      expect(result.dewPoint, 20.59);
      expect(result.windSpeed, 9.27);
      expect(result.windDirection, 30);
      expect(result.windGust, 10.03);
      expect(result.conditions, isA<List<WeatherConditionModel>>());
      expect(result.conditions.first, isA<WeatherConditionModel>());
      expect(result.cloudiness, 100);
      expect(result.pop, 0);
      expect(result.uVIndex, 10.97);
    },
  );
}
