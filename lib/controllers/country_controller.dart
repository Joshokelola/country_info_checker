import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/country.dart';
import '../services/country_api_service.dart';

class CountryNotifier extends AsyncNotifier<List<Country>?> {
  List<Country>? _allCountries;
  String _searchQuery = '';

  @override
  FutureOr<List<Country>?> build() async {
    _allCountries = await CountryApiService().getAllCountries();
    return _filterCountries();
  }

  List<Country>? _filterCountries() {
    if (_allCountries == null) return null;
    if (_searchQuery.isEmpty) return _allCountries;
    
    return _allCountries!.where((country) =>
      country.name.toLowerCase().contains(_searchQuery.toLowerCase())
    ).toList();
  }

  void searchCountries(String query) {
    _searchQuery = query;
    state = AsyncData(_filterCountries());
  }
}
final countryNotifierProvider = AsyncNotifierProvider<CountryNotifier, List<Country>? >(CountryNotifier.new);