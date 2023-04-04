import 'package:swc_front/data/apis/current_user.dart';
import 'package:swc_front/data/models/user.dart';

class AuthenticationRepository {
  final AuthenticationAPI _api = AuthenticationAPI();

  Future<User> fetch() async {
    dynamic user = await _api.fetch();
    return User.fromMap(user);
  }

  Future<User> create(User user, String password) async {
    Map<String, dynamic> userFields = user.toMap();
    userFields['password'] = password;
    Map<String, dynamic> rawUser = await _api.create(userFields);
    return User.fromMap(rawUser);
  }

  Future<User> update(User user) async {
    Map<String, dynamic> rawUser = await _api.update(user.toMap());
    return User.fromMap(rawUser);
  }

  Future<String> login(String email, String password) async {
    String rawToken = await _api.login(email, password);
    return rawToken;
  }
}
