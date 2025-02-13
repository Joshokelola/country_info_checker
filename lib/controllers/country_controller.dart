import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/country.dart';
import '../services/country_api_service.dart';

class CountryNotifier extends AsyncNotifier<List<Country>?> {
  List<Country>? _allCountries;
  String _searchQuery = '';
  List<String> _selectedContinents = [];
  List<String> _selectedTimeZones = [];

  @override
  FutureOr<List<Country>?> build() async {
    _allCountries = await CountryApiService().getAllCountries();
    return _filterCountries();
  }

  List<Country>? _filterCountries() {
    if (_allCountries == null) return null;

    List<Country> filteredCountries = _allCountries!;

    if (_searchQuery.isNotEmpty) {
      filteredCountries = filteredCountries
          .where((country) =>
              country.name!.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    if (_selectedContinents.isNotEmpty) {
      filteredCountries = filteredCountries
          .where((country) => _selectedContinents.contains(
              country.continents.isEmpty ? '' : country.continents.first))
          .toList();
    }

    if (_selectedTimeZones.isNotEmpty) {
      filteredCountries = filteredCountries
          .where((country) => _selectedTimeZones.contains(
              country.timeZones!.isEmpty ? '' : country.timeZones!.first))
          .toList();
    }

    return filteredCountries;
  }

  void searchCountries(String query) {
    _searchQuery = query;
    state = AsyncData(_filterCountries());
  }

  void applyFilters(List<String> continents, List<String> timeZones) {
    _selectedContinents = continents;
    _selectedTimeZones = timeZones;
    state = AsyncData(_filterCountries());
  }
}

final countryNotifierProvider =
    AsyncNotifierProvider<CountryNotifier, List<Country>?>(CountryNotifier.new);
