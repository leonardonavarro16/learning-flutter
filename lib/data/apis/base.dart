import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart';

abstract class BaseAPI {
  //final String baseUrl = 'http://localhost:3000';

  final bool debug = dotenv.env['DEBUG'] == 'true';
  final String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  Future<Response> httpGet(String url) {
    return get(Uri.parse(url));
  }

  Future<Response> httpPost(String url, {required String body, String? token}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    if (token != null) headers['Authorization'] = "Bearer $token";
    return post(Uri.parse(url), headers: headers, body: body);
  }

  Future<Response> httpPut(String url, {required String body, String? token}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    if (token != null) headers['Authorization'] = "Bearer $token";
    return put(Uri.parse(url), headers: headers, body: body);
  }
}
