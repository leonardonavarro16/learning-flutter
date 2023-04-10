import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/data/apis/authentication.dart';

class AuthenticationRepository {
  final AuthenticationAPI _api = AuthenticationAPI();

  Future<User> create(User user, String password) async {
    Map<String, dynamic> userFields = user.toMap();
    userFields['password'] = password;
    Map<String, dynamic> rawUser = await _api.create(userFields);
    return User.fromMap(rawUser);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> response = await _api.login(email, password);
    return {
      'token': response['token'],
      'user': User.fromMap(response['user']),
    };
  }
}
