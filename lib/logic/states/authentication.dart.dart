import 'package:swc_front/data/models/user.dart';

enum UserStatus { initial, loading, success, failure }

class AuthenticationState {
  final User user;
  final String error;
  final UserStatus userStatus;
  final String? token;

  AuthenticationState({
    required this.user,
    required this.error,
    required this.userStatus,
    this.token,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
      user: User(desiredAge: 0, name: '', phoneNumber: ''),
      error: '',
      userStatus: UserStatus.initial,
    );
  }

  AuthenticationState copyWith(
      {UserStatus? userStatus, String? error, User? user, String? token}) {
    return AuthenticationState(
        user: user ?? this.user,
        error: error ?? this.error,
        userStatus: userStatus ?? this.userStatus,
        token: token ?? this.token);
  }
}
