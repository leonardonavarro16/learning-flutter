import 'dart:convert';
import 'package:http/http.dart';

import 'base.dart';

class AdvertsAPI extends BaseAPI {
  Future<List<dynamic>> fetchAll() async {
    final response = await httpGet('${baseUrl()}/adverts');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }

  Future<Map<String, dynamic>> create(
    Map<String, dynamic> rawAdvert,
    String token,
  ) async {
    String body = jsonEncode({'advert': rawAdvert});

    final Response response = await httpPost(
      '${baseUrl()}/adverts',
      body: body,
      token: token,
    );
    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final error = jsonDecode(response.body)['error'];
      throw Exception(error);
    }
  }
}
