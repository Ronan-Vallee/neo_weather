import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ICityLocalDataSource {
  Future<List<Map<String, dynamic>>> getSavedCities();
  Future<Unit> saveCity(Map<String, dynamic> cityData);
  Future<Unit> removeCity(String cityName);
}

class CityLocalDataSource implements ICityLocalDataSource {
  final Box<String> cityBox;

  CityLocalDataSource({required this.cityBox});

  @override
  Future<List<Map<String, dynamic>>> getSavedCities() async {
    return cityBox.values
        .map((cityJson) => json.decode(cityJson) as Map<String, dynamic>)
        .toList();
  }

  @override
  Future<Unit> saveCity(Map<String, dynamic> cityData) async {
    final cityJson = json.encode(cityData);
    await cityBox.put("${cityData['name']},${cityData['state']}", cityJson);
    return unit;
  }

  @override
  Future<Unit> removeCity(String cityKey) async {
    await cityBox.delete(cityKey);
    return unit;
  }
}
