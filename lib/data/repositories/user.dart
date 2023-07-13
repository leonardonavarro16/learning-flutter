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

  Future<List<User>> fetchUsers(String? token) async {
    List<dynamic> rawUsers = await _api.fetchUsers(token);
    return rawUsers.map<User>((dynamic rawUsers) {
      return User.fromMap(rawUsers);
    }).toList();
  }
}
