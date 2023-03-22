import 'package:swc_front/data/apis/current_user.dart';

import '../models/user.dart';

class CurrentUserRepository {
  final CurrentUserAPI _api = CurrentUserAPI();

  Future<User> fetch() async {
    dynamic user = await _api.fetch();
    return user.map<User>((dynamic user) {
      return User.fromMap(user);
    }).toList();
  }
}


//todo: crear clase CurrentUserAPI --DONE
//todo: crear un atributo llamador user a la clase api y retornar siempre a este--DONE
//todo: crear el metodo User.fromMap --DONE