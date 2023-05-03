import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;

abstract class BaseAPI {
  String baseUrl() {
    String? baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('The API_URL env variable is not defined');
    }
    return baseUrl;
  }

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

  Future<Uint8List> getBytesFromUrl(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to load image');
    }
  }
}
