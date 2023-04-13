import 'package:swc_front/data/apis/user.dart';
import 'package:swc_front/data/models/user.dart';

class UserRepository {
  final UserAPI _api = UserAPI();

  Future<User> updateUser(User user, String token) async {
    final Map<String, dynamic> rawUser = await _api.update(user.toMap(), token);
    return User.fromMap(rawUser);
  }
}
