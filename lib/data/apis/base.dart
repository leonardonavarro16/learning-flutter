import 'dart:typed_data';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

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

  Future<Response> httpMultipartRequest(
    // todo: form data post , un método para reutilizar la forma en la que se hace post con formdata
    String url,
    String token,
    Map<String, String> fields,
    List<Uint8List> images,
  ) async {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );

    request.headers['authorization'] = 'Bearer $token';

    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    for (int i = 0; i < images.length; i++) {
      final bytes = images[i];
      final mimeType = lookupMimeType('', headerBytes: bytes);
      final multipartFile = http.MultipartFile.fromBytes(
        'image$i',
        bytes,
        filename: 'image$i',
        contentType: MediaType.parse(mimeType!),
      );
      request.files.add(multipartFile);
    }

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseString = await response.stream.bytesToString();
      return jsonDecode(responseString);
      // final responseString = await response.stream.bytesToString();
      // return Response.fromStream(
      //   response.stream.transform(utf8.decoder),
      //   response.statusCode,
      //   headers: response.headers,
      // );
    } else {
      throw Exception('Failed to create advert');
    }
  }

  // Future<Response> httpMultipartRequest(required String body, String url, String? token){
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json; charset=UTF-8'
  //   };
  //   if (token != null) headers['Authorization'] = "Bearer $token";
  //   return post(Uri.parse(url), headers: headers, body: body);

  // }

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
