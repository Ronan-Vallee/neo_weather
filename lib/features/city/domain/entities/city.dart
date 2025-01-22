import 'package:equatable/equatable.dart';

class City extends Equatable {
  final String name;
  final double latitude;
  final double longitude;
  final String country;
  final String? state;

  const City({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.state,
  });

  @override
  List<Object?> get props => [name, latitude, longitude, country, state];
}
