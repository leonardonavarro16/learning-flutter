import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:swc_front/data/apis/base.dart';
import 'package:http/http.dart';

class UserAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(Map<String, dynamic> rawUser) async {
    String body = jsonEncode({'user': rawUser});

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('${baseUrl()}/users'),
    );

    request.fields.addAll({
      'user[email]': rawUser['email'],
      'user[phone]': rawUser['phone'],
      'user[fullname]': rawUser['fullname'],
      'user[age]': rawUser['age']?.toString() ?? '20',
      'user[birthdate]': rawUser['birthdate'],
      'user[password]': rawUser['password'],
    });

    // Add image files to the request
    final bytes = rawUser['image'];
    final mimeType = lookupMimeType('', headerBytes: bytes);
    final multipartFile = http.MultipartFile.fromBytes(
      'user[image]',
      bytes,
      filename: 'image',
      contentType: MediaType.parse(mimeType!),
    );
    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();

      Map<String, dynamic> user = jsonDecode(responseBody);
      await downloadUserImage(user);

      return user;
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<Map<String, dynamic>> update(
      Map<String, dynamic> userFields, String token) async {
    final Response response = await httpPut(
      '${baseUrl()}/users/${userFields['id']}',
      body: jsonEncode({'user': userFields}),
      token: token,
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['user'];
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<void> downloadUserImage(Map<String, dynamic> rawUser) async {
    bool downloadImage = rawUser['image'] != null;
    if (downloadImage) {
      rawUser['image'] = await getBytesFromUrl(rawUser['image']);
    }
  }
}
