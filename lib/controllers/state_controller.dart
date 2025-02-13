// import 'dart:async';

// import 'package:country_info_checker/model/state.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../services/country_api_service.dart';

// class GetStatesNotifier extends FamilyAsyncNotifier<List<State>, String> {
//   final CountryApiService _apiService = CountryApiService();
//   @override
//   FutureOr<List<State>> build(String arg) {
//     return _apiService.getStatesForCountry(arg);
//   }
// }

// final getStatesProvider =
//     AsyncNotifierProviderFamily<GetStatesNotifier, List<State>, String>(
//         GetStatesNotifier.new);
