import 'package:http/http.dart';

abstract class BaseAPI {
  final String baseUrl = 'http://localhost:3000';

  Future<Response> httpGet(String url) {
    return get(Uri.parse(url));
  }

  Future<Response> httpPost(String url, {required String body}) {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    return post(Uri.parse(url), headers: headers, body: body);
  }
}
