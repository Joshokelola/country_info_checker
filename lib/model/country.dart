import 'dart:convert';

import 'state.dart';

class Country {
  final String name; 
  final String capital; 
  String? statesUrl;
  List<State>? states;
  final String flagImage; 
  final String population; 
  final String president;
  final String continent;
  final String countryCode;

  Country({
    required this.name,
    required this.capital,
    required this.statesUrl,
    this.states = const [],
    required this.flagImage,
    required this.population,
    required this.president,
    required this.continent,
    required this.countryCode,
  });

  void setStates(List<State> states) {
    this.states = states;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'capital': capital,
      'statesUrl': statesUrl,
      'states': states?.map((x) => x.toMap()).toList(),
      'flagImage': flagImage,
      'population': population,
      'president': president,
      'continent': continent,
      'countryCode': countryCode,
    };
  }

  factory Country.fromMap(Map<String, dynamic> map) {
    // Safely access nested fields with null checks
    final href = map['href'] as Map<String, dynamic>? ?? {};
    final currentPresident = map['current_president'] as Map<String, dynamic>? ?? {};

    return Country(
      name: map['name'] as String? ?? '',
      capital: map['capital'] as String? ?? '',
      statesUrl: href['states'] as String? ?? '',
      flagImage: href['flag'] as String? ?? '',
      population: map['population'] as String? ?? '',
      president: currentPresident['name'] as String? ?? '',
      continent: map['continent'] as String? ?? '',
      countryCode: map['iso3'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Country.fromJson(String source) => Country.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Country(name: $name, capital: $capital, states: $states, flagImage: $flagImage, population: $population, president: $president, continent: $continent, countryCode: $countryCode)';
  }
}