extension WeatherIconUrl on String {
  String toWeatherIconURL({bool highResolution = true}) {
    const baseUrl = 'https://openweathermap.org/img/wn/';
    final resolutionSuffix = highResolution ? '@4x.png' : '.png';
    return '$baseUrl$this$resolutionSuffix';
  }
}
