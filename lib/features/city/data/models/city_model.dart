import '../../domain/entities/city.dart';

class CityModel extends City {
  const CityModel({
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.country,
    required super.state,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) {
    final name =
        json['local_names'] != null && json['local_names']['fr'] != null
            ? json['local_names']['fr'] as String
            : json['name'] as String;

    return CityModel(
      name: name,
      latitude: json['lat'] as double,
      longitude: json['lon'] as double,
      country: json['country'] as String,
      state: json['state'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'lat': latitude,
      'lon': longitude,
      'country': country,
      'state': state,
    };
  }

  @override
  List<Object?> get props => [name, country, state];
}
