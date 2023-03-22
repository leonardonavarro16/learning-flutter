import 'package:swc_front/data/models/user.dart';

abstract class CurrentUserState {}

class CurrentUserInitial extends CurrentUserState {}

class CurrentUserFetchSuccess extends CurrentUserState {
  User user;

  CurrentUserFetchSuccess({required this.user});
}
