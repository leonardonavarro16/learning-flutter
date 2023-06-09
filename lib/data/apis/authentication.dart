import 'dart:convert';
import 'package:swc_front/data/apis/base.dart';

import '../../presentation/widgets/utils/map.dart';

class AuthenticationAPI extends BaseAPI {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await httpPost(
      '${baseUrl()}/auth/login',
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> loginInfo = jsonDecode(response.body);
      return loginInfo;
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> update(
    Map<String, dynamic> user,
    String token,
  ) async {
    Map<String, dynamic> files =
        MapUtils.removeKeysAndGetRemoved(user, ['image']);
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
      throw Exception('Error: ${response.statusCode}');
    }
  }
}
