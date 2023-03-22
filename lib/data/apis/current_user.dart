import 'package:swc_front/data/models/user.dart';

class CurrentUserAPI {
  final Map<String, dynamic> _user = {};

  CurrentUserAPI();

  fetch() {
    return _user;
  }
}
