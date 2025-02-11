import 'package:country_info_checker/model/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CountryApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://restfulcountries.com/api/v1';
  static const String _authToken =
      '2099|JJVIQG5ytF0hN1TJinuecsPrSGucDFk9o9I7V2o6';

  CountryApiService() : _dio = Dio() {
    _dio.options.headers['Authorization'] = 'Bearer $_authToken';
    _dio.options.baseUrl = _baseUrl;
  }

  Future<List<Country>?> getAllCountries() async {
    try {
      final response = await _dio.get('/countries');
      final countryResponseData = response.data['data'] as List<dynamic>? ?? [];

      final countries = countryResponseData.map((e) {
        return Country.fromMap(e);
      }).toList();

      debugPrint(countries[0].toString());
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
