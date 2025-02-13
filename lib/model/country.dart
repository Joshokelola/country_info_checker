class Country {
  final String? name;
  final String? cca3;
  final List<String> capital;
  final String? region;
  final List<String> continents;
  final int? population;
  final Map<String, dynamic>? flags;
  final Map<String, dynamic>? languages;
  final double? area;
  final List<String>? currencies;
  final List<String>? timeZones;
  final Map<String, dynamic>? dialingCodes;
  final Map<String, dynamic>? drivingSide;
  final Map<String, dynamic>? coatOfArms;

  Country({
    this.name,
    this.cca3,
    this.capital = const [],
    this.region,
    this.continents = const [],
    this.population,
    this.flags,
    this.languages,
    this.area,
    this.currencies,
    this.timeZones,
    this.dialingCodes,
    this.drivingSide,
    this.coatOfArms,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name']['common'],
      cca3: json['cca3'],
      capital: List<String>.from(json['capital'] ?? []),
      continents: List<String>.from(json['continents'] ?? []),
      population: json['population'],
      flags: json['flags'],
      languages: json['languages'],
      area: json['area'],
      currencies: json['currencies'],
      timeZones: json['timezones'],
      dialingCodes: json['idd'],
      drivingSide: json['car'],
      coatOfArms: json['coatOfArms'],
    );
  }



  @override
  String toString() {
    return 'Country(name: $name, cca3: $cca3, capital: $capital, region: $region, continents: $continents, population: $population, flags: $flags, languages: $languages, area: $area, currencies: $currencies, timeZones: $timeZones, dialingCodes: $dialingCodes, drivingSide: $drivingSide, coatOfArms: $coatOfArms)';
  }
}
