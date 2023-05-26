import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

import 'package:swc_front/data/apis/base.dart';
import 'package:swc_front/presentation/widgets/utils/map.dart';

class UserAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(Map<String, dynamic> rawUser) async {
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

      return jsonDecode(responseBody);
    } else {
      throw Exception('Failed to create user');
    }
  }

  Future<Map<String, dynamic>> update(
    Map<String, dynamic> user,
    String token,
  ) async {
    Map<String, dynamic> files = MapUtils.removeKeysAndGetRemoved(user, [
      'image',
    ]);
    Map<String, dynamic> userFields = {"user": user};
    Map<String, dynamic> userFiles = {"user": files};
    final response = await formDataPut(
      "${baseUrl()}/users/${user['id']}",
      fields: MapUtils.convertMapToStringValues(
        MapUtils.formatAsFormDataMap(userFields),
      ),
      files: MapUtils.formatAsFormDataMap(userFiles),
      token: token,
    );
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return jsonDecode(responseBody)['user'];
    } else {
      throw Exception('Error en la solicitud: ${response.statusCode}');
    }
  }
}
