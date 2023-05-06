import 'dart:convert';

import 'package:http/http.dart';
import 'package:swc_front/data/apis/base.dart';

class UserAPI extends BaseAPI {
  Future<Map<String, dynamic>> create(Map<String, dynamic> rawUser) async {
    String body = jsonEncode({'user': rawUser});
    final response = await httpPost(
      '${baseUrl()}/users',
      body: body,
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
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
}
