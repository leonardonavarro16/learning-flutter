import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swc_front/data/apis/base.dart';
import 'package:swc_front/presentation/forms/login_form.dart';

class CurrentUserAPI extends BaseAPI {
  final Map<String, dynamic> _user = {
    'name': 'pollo',
    'desiredAge': 19,
    'phoneNumber': '+57 301 323 7812',
  };

  Future<Map<String, dynamic>> fetch() async {
    return _user;
  }

  Future<Map<String, String>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load user');
    }
  }

  Future<Map<String, dynamic>> update(user) async {
    await Future.delayed(const Duration(seconds: 1));
    _user.addAll(user);
    return _user;
  }
}
