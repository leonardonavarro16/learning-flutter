import 'dart:convert';
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
      Map<String, dynamic> loginInfo = jsonDecode(response.body);
      await downloadUserImage(loginInfo);

      return loginInfo;
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<void> downloadUserImage(Map<String, dynamic> rawUser) async {
    bool downloadImage = rawUser['user']['image'] != null;
    if (downloadImage) {
      rawUser['user']['image'] =
          await getBytesFromUrl(rawUser['user']['image']);
    }
  }
}
