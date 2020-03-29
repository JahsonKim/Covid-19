
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:virus/model/Covid.dart';

class MyPreferences {

  final String topTenCountries = "TopTen";
  final String cases = "cases";

  Future<dynamic> clearPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<dynamic> setCases(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cases, value);
    return null;
  }

  Future<Covid> getCases() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(cases) ?? "";
    final res = json.decode(value);
    Covid covid=Covid.map(res);
    return covid;
  }
  Future<dynamic> setTopTen(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(topTenCountries, value);
    return null;
  }

  Future<dynamic> getTopTen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString(topTenCountries) ?? "";
    final res = json.decode(value);
    return res;
  }

}