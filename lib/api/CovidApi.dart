import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CovidApi {
  static CovidApi _instance = new CovidApi.internal();

  CovidApi.internal();

  bool trustSelfSigned = true;

  factory CovidApi() => _instance;

  Future<String> get(String url, {Map headers, encoding}) {
    return http.get(url, headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        return res;
        throw new Exception(res);
      }
      return res;
    });
  }

  Future<String> post(String url, {Map headers, body, encoding}) async {
    try {
      final response = await http.post(url,
          body: body, headers: headers, encoding: encoding);
      if (response.statusCode == 200) {
        return response.body.toString();
      } else {
        return response.body.toString();
      }
    } catch (e) {
      return e.toString();
    }
  }


}
