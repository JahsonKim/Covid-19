import 'dart:async';
import 'package:virus/utils/Constants.dart';
import 'CovidApi.dart';

class RestDatasource {
  CovidApi _netUtil = new CovidApi();

  Future<String> getAllCases() {
    return _netUtil.get(ALL_CASES);
  }

  Future<String> getAllCountries() {
    return _netUtil.get(ALL_COUNTRIES + "?sort=cases");
  }

  Future<String> getCaseByCountry(String country) {
    return _netUtil.get(CASES_PER_COUNTRY + "${country}");
  }




}
