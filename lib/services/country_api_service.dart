import 'package:country_info_checker/model/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CountryApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://restcountries.com/v3.1';

  CountryApiService() : _dio = Dio() {
    
    _dio.options.baseUrl = _baseUrl;
  }

  Future<List<Country>?> getAllCountries() async {
    try {
      final response = await _dio.get('/all');
      final countryResponseData = response.data as List<dynamic>? ?? [];
      
      final countries = countryResponseData.map((e) {
        var countryDecoded = Country.fromJson(e);

        return countryDecoded;
      }).toList();

      debugPrint(countries.length.toString());
      return countries;
    } on DioException catch (e) {
      debugPrint('Network error: ${e.message}');
      if (e.response != null) {
        debugPrint('Error response: ${e.response?.data}');
      }
      return null;
    } catch (e, stackTrace) {
      debugPrint('Unexpected error: $e');
      debugPrint('Stack trace: $stackTrace');
      return null;
    }
  }
}
