import 'package:flutter/foundation.dart';
import 'package:swc_front/data/models/user.dart';

class CurrentUserState extends ChangeNotifier {
  User? user =
      User(name: 'javier roncallo', desiredAge: 26, phoneNumber: '3004988692');

  void update(User user) {
    this.user = user;
    notifyListeners();
  }
}
