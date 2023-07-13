import 'package:swc_front/data/models/user.dart';

enum UserStatus {
  initial,
  loading,
  createSuccess,
  createFailure,
  userSuccess,
  userFailure
}

class UserState {
  final List<User> users;
  final String? error;
  final UserStatus userStatus;

  UserState({
    required this.users,
    required this.error,
    required this.userStatus,
  });

  factory UserState.initial() {
    return UserState(
      users: [],
      error: null,
      userStatus: UserStatus.initial,
    );
  }

  UserState copyWith({
    UserStatus? userStatus,
    String? error,
    List<User>? users,
  }) {
    return UserState(
        users: users ?? this.users,
        error: error ?? this.error,
        userStatus: userStatus ?? this.userStatus);
  }
}
