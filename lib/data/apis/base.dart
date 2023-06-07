import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

abstract class BaseAPI {
  String baseUrl() {
    String? baseUrl = dotenv.env['API_URL'];
    if (baseUrl == null) {
      throw Exception('The API_URL env variable is not defined');
    }
    return baseUrl;
  }

  Future<Response> httpGet(String url, {String? token}) {
    Map<String, String>? headers =
        token == null ? null : {'Authorization': "Bearer $token"};
    return get(Uri.parse(url), headers: headers);
  }

  Future<Response> httpPost(String url, {String? body, String? token}) {
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

  Future<StreamedResponse> formDataPut(
    String url, {
    required Map<String, String> fields,
    String? token,
    Map<String, dynamic>? files,
  }) async {
    final request = MultipartRequest(
      'PUT',
      Uri.parse(url),
    );
    setRequestData(request, fields: fields, token: token, files: files);
    var response = await request.send();
    return response;
  }

  void setRequestData(
    request, {
    required Map<String, String> fields,
    String? token,
    Map<String, dynamic>? files,
  }) {
    if (token != null) request.headers['Authorization'] = 'Bearer $token';
    request.fields.addAll(fields);
    if (files != null) {
      files.forEach((String key, dynamic value) {
        if (value is Uint8List) {
          addFileToFormDataRequest(request, key, value);
        } else if (value is List<Uint8List>) {
          for (Uint8List bytes in value) {
            addFileToFormDataRequest(request, key, bytes);
          }
        } else {
          throw Exception("Invalid file bytes");
        }
      });
    }
  }

  void addFileToFormDataRequest(request, String key, Uint8List bytes) {
    final mimeType = lookupMimeType('', headerBytes: bytes);
    final multipartFile = MultipartFile.fromBytes(
      key,
      bytes,
      filename: 'file',
      contentType: MediaType.parse(mimeType!),
    );
    request.files.add(multipartFile);
  }
}
