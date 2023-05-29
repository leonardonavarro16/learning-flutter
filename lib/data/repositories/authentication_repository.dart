import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/data/apis/authentication.dart';
import 'package:swc_front/data/repositories/base.dart';

class AuthenticationRepository extends BaseRepository {
  final AuthenticationAPI _api = AuthenticationAPI();

  Future<Map<String, dynamic>> login(String email, String password) async {
    Map<String, dynamic> response = await _api.login(email, password);
    await downloadUserImage(response['user']);
    return {
      'token': response['token'],
      'user': User.fromMap(response['user']),
    };
  }

  Future<User> update(User user, String token) async {
    final Map<String, dynamic> rawUser = await _api.update(user.toMap(), token);
    await downloadUserImage(rawUser);
    return User.fromMap(rawUser);
  }
}
