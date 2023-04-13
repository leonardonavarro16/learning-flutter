import 'package:swc_front/data/models/user.dart';

enum UserStatus { initial, loading, success, failure }

class UserState {
  final User? user;
  final String? error;
  final UserStatus userStatus;

  UserState({
    required this.user,
    required this.error,
    required this.userStatus,
  });

  factory UserState.initial() {
    return UserState(
      user: null,
      error: null,
      userStatus: UserStatus.initial,
    );
  }

  UserState copyWith({
    UserStatus? userStatus,
    String? error,
    User? user,
  }) {
    return UserState(
        user: user ?? this.user,
        error: error ?? this.error,
        userStatus: userStatus ?? this.userStatus);
  }
}
