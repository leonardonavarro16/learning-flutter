import 'package:swc_front/data/apis/current_user.dart';
import 'package:swc_front/data/models/user.dart';

class CurrentUserRepository {
  final CurrentUserAPI _api = CurrentUserAPI();

  Future<User> fetch() async {
    dynamic user = await _api.fetch();
    return User.fromMap(user);
  }

  Future<User> update(User user) async {
    Map<String, dynamic> rawUser = await _api.update(user.toMap());
    return User.fromMap(rawUser);
  }
}
