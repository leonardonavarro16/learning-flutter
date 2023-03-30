import 'package:swc_front/data/models/user.dart';

enum UserStatus { initial, loading, success, failure }

class UserState {
  final User user;
  final String error;
  final UserStatus userStatus;
  final String? token;

  UserState({
    required this.user,
    required this.error,
    required this.userStatus,
    this.token,
  });

  factory UserState.initial() {
    return UserState(
      user: User(desiredAge: 0, name: '', phoneNumber: ''),
      error: '',
      userStatus: UserStatus.initial,
    );
  }

  UserState copyWith(
      {UserStatus? userStatus, String? error, User? user, String? token}) {
    return UserState(
        user: user ?? this.user,
        error: error ?? this.error,
        userStatus: userStatus ?? this.userStatus,
        token: token ?? this.token);
  }
}
