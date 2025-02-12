import 'package:country_info_checker/model/country.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:country_info_checker/model/state.dart' as s;

import '../utils/api_key.dart';

class CountryApiService {
  final Dio _dio;
  static const String _baseUrl = 'https://restfulcountries.com/api/v1';


  CountryApiService() : _dio = Dio() {
    _dio.options.headers['Authorization'] = 'Bearer $authToken';
    _dio.options.baseUrl = _baseUrl;
  }
  Future<List<s.State>> getStatesForCountry(String statesUrl) async {
    try {
      final response = await _dio.get(statesUrl);
      final stateResponseData = response.data['data'] as List<dynamic>? ?? [];
      return stateResponseData.map((e) => s.State.fromMap(e)).toList();
    } on DioException catch (e) {
     debugPrint('Network error fetching states, error - $e');
      return [];
    } catch (e, stackTrace) {
     debugPrint('Unexpected error fetching states, error - $e, stacktrace - $stackTrace');
      return [];
    }
  }
  Future<List<Country>?> getAllCountries() async {
    try {
      final response = await _dio.get('/countries');
      final countryResponseData = response.data['data'] as List<dynamic>? ?? [];

      final countries = 
      countryResponseData.map((e)  {
        var countryDecoded = Country.fromMap(e);
       
      
        return countryDecoded;
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
