import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/data/apis/authentication.dart';

class AuthenticationRepository {
  final AuthenticationAPI _api = AuthenticationAPI();
  // final UserAPI _api = UserAPI();

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> response = await _api.login(email, password);
    return {
      'token': response['token'],
      'user': User.fromMap(response['user']),
    };
  }
}
