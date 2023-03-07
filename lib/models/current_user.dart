import 'package:flutter/foundation.dart';
import 'package:swc_front/models/user.dart';

class CurrentUser extends ChangeNotifier {
  User? user;

  void update(User user) {
    this.user = user;
    notifyListeners();
  }
}
