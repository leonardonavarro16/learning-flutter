import 'package:swc_front/data/models/user.dart';

enum UserStatus { initial, loading, createSuccess, createFailure }

class UserState {
  final String? error;
  final UserStatus userStatus;

  UserState({
    required this.error,
    required this.userStatus,
  });

  factory UserState.initial() {
    return UserState(
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
        error: error ?? this.error, userStatus: userStatus ?? this.userStatus);
  }
}
