import 'package:equatable/equatable.dart';

class Temperature extends Equatable {
  final double day;
  final double? morning;
  final double? evening;
  final double? night;
  final double? min;
  final double? max;

  const Temperature({
    required this.day,
    this.morning,
    this.evening,
    this.night,
    this.min,
    this.max,
  });

  @override
  List<Object?> get props => [
        day,
        morning,
        evening,
        night,
        min,
        max,
      ];
}
