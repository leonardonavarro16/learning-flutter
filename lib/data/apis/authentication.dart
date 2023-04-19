import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swc_front/data/apis/base.dart';

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
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }
}