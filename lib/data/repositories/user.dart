import 'package:swc_front/data/apis/user.dart';
import 'package:swc_front/data/models/user.dart';

import 'base.dart';

class UserRepository extends BaseRepository {
  final UserAPI _api = UserAPI();

  Future<User> create(User user, String password) async {
    Map<String, dynamic> userFields = user.toMap();
    userFields['password'] = password;
    Map<String, dynamic> rawUser = await _api.create(userFields);
    await downloadUserImage(rawUser);
    return User.fromMap(rawUser);
  }

  Future<User> updateUser(User user, String token) async {
    final Map<String, dynamic> rawUser = await _api.update(user.toMap(), token);
    await downloadUserImage(rawUser);
    return User.fromMap(rawUser);
  }
}
