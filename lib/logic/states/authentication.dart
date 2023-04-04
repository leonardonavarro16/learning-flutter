import 'package:swc_front/data/models/user.dart';

enum AuthenticationStatus { initial, loading, success, failure }

class AuthenticationState {
  final User? user;
  final String? error;
  final AuthenticationStatus authenticationStatus;
  final String? token;

  AuthenticationState({
    required this.user,
    required this.error,
    required this.authenticationStatus,
    this.token,
  });

  factory AuthenticationState.initial() {
    return AuthenticationState(
      user: null,
      error: null,
      authenticationStatus: AuthenticationStatus.initial,
    );
  }

  AuthenticationState copyWith(
      {AuthenticationStatus? authenticationStatus,
      String? error,
      User? user,
      String? token}) {
    return AuthenticationState(
        user: user ?? this.user,
        error: error ?? this.error,
        authenticationStatus: authenticationStatus ?? this.authenticationStatus,
        token: token ?? this.token);
  }
}
