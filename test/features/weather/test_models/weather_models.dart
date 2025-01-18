import 'package:neo_weather/features/weather/data/models/temperature_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_condition_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_data_model.dart';
import 'package:neo_weather/features/weather/data/models/weather_model.dart';
import 'package:neo_weather/features/weather/domain/entities/weather_condition.dart';

final WeatherModel tWeatherModel = WeatherModel(
  latitude: 48.858,
  longitude: 2.294,
  timezone: "Etc/GMT-3",
  timezoneOffset: 10800,
  current: tCurrentWeatherDataModel,
  hourly: [tHourlyWeatherDataModel],
  daily: [tDailyWeatherDataModel],
);

final WeatherDataModel tCurrentWeatherDataModel = WeatherDataModel(
  dateTime: DateTime.fromMillisecondsSinceEpoch(1737152323 * 1000),
  sunrise: DateTime.fromMillisecondsSinceEpoch(1737168879 * 1000),
  sunset: DateTime.fromMillisecondsSinceEpoch(1737212092 * 1000),
  temperature: const TemperatureModel(day: 25.22),
  perceivedTemperature: const TemperatureModel(day: 25.86),
  pressure: 1012,
  humidity: 79,
  dewPoint: 21.32,
  uVIndex: 0.3,
  cloudiness: 77,
  visibility: 10000,
  windSpeed: 8.84,
  windDirection: 33,
  windGust: 9.52,
  rain: 1.1,
  snow: 1.1,
  conditions: [tWeatherConditionModel],
);

final WeatherDataModel tHourlyWeatherDataModel = WeatherDataModel(
  dateTime: DateTime.fromMillisecondsSinceEpoch(1737151200 * 1000),
  temperature: const TemperatureModel(day: 25.22),
  perceivedTemperature: const TemperatureModel(day: 25.86),
  pressure: 1012,
  humidity: 79,
  dewPoint: 21.32,
  uVIndex: 0,
  cloudiness: 77,
  visibility: 10000,
  windSpeed: 8.84,
  windDirection: 33,
  windGust: 9.52,
  pop: 0.5,
  rain: 1.1,
  snow: 1.1,
  conditions: [tWeatherConditionModel],
);

final WeatherDataModel tDailyWeatherDataModel = WeatherDataModel(
  dateTime: DateTime.fromMillisecondsSinceEpoch(1737187200 * 1000),
  sunrise: DateTime.fromMillisecondsSinceEpoch(1737168879 * 1000),
  sunset: DateTime.fromMillisecondsSinceEpoch(1737212092 * 1000),
  temperature: const TemperatureModel(
    day: 25.44,
    min: 25.13,
    max: 25.46,
    night: 25.13,
    evening: 25.3,
    morning: 25.3,
  ),
  perceivedTemperature: const TemperatureModel(
    day: 25.97,
    night: 25.66,
    evening: 25.82,
    morning: 25.9,
  ),
  pressure: 1012,
  humidity: 74,
  dewPoint: 20.59,
  uVIndex: 10.97,
  cloudiness: 100,
  windSpeed: 9.27,
  windDirection: 30,
  windGust: 10.03,
  pop: 0,
  conditions: [tWeatherConditionModel],
);

const tWeatherCondition = WeatherCondition(
  id: 803,
  main: "Clouds",
  description: "nuageux",
  icon: "04n",
);

const tWeatherConditionModel = WeatherConditionModel(
  id: 803,
  main: "Clouds",
  description: "nuageux",
  icon: "04n",
);

final tWeatherModelJSON = {
  "lat": 48.858,
  "lon": 2.294,
  "timezone": "Etc/GMT-3",
  "timezone_offset": 10800,
  "current": tCurrentWeatherDataModelJSON,
  "hourly": [tHourlyWeatherDataModelJSON],
  "daily": [tDailyWeatherDataModelJSON],
};

final tCurrentWeatherDataModelJSON = {
  "dt": 1737152323,
  "sunrise": 1737168879,
  "sunset": 1737212092,
  "temp": 25.22,
  "feels_like": 25.86,
  "pressure": 1012,
  "humidity": 79,
  "dew_point": 21.32,
  "uvi": 0.3,
  "clouds": 77,
  "visibility": 10000,
  "wind_speed": 8.84,
  "wind_deg": 33,
  "wind_gust": 9.52,
  "rain": 1.1,
  "snow": 1.1,
  "weather": [tWeatherConditionModelJSON]
};

final tHourlyWeatherDataModelJSON = {
  "dt": 1737151200,
  "temp": 25.22,
  "feels_like": 25.86,
  "pressure": 1012,
  "humidity": 79,
  "dew_point": 21.32,
  "uvi": 0,
  "clouds": 77,
  "visibility": 10000,
  "wind_speed": 8.84,
  "wind_deg": 33,
  "wind_gust": 9.52,
  "pop": 0.5,
  "rain": 1.1,
  "snow": 1.1,
  "weather": [tWeatherConditionModelJSON]
};

final tDailyWeatherDataModelJSON = {
  "dt": 1737187200,
  "sunrise": 1737168879,
  "sunset": 1737212092,
  "moonrise": 1737225300,
  "moonset": 1737180900,
  "moon_phase": 0.64,
  "summary": "There will be partly cloudy today",
  "temp": tTemperatureModelJSON,
  "feels_like": {"day": 25.97, "night": 25.66, "eve": 25.82, "morn": 25.9},
  "pressure": 1012,
  "humidity": 74,
  "dew_point": 20.59,
  "wind_speed": 9.27,
  "wind_deg": 30,
  "wind_gust": 10.03,
  "weather": [tWeatherConditionModelJSON],
  "clouds": 100,
  "pop": 0,
  "uvi": 10.97
};

final tWeatherConditionModelJSON = {
  "id": 803,
  "main": "Clouds",
  "description": "nuageux",
  "icon": "04n",
};

final tTemperatureModelJSON = {
  "day": 25.44,
  "min": 25.13,
  "max": 25.46,
  "night": 25.13,
  "eve": 25.3,
  "morn": 25.3,
};
