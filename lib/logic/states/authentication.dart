import 'dart:convert';

import 'package:swc_front/data/models/user.dart';

enum AuthenticationStatus {
  initial,
  loading,
  successLogin,
  failureLogin,
  updateSuccess,
  updateFailure,
  successLogout
}

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
      token: null,
    );
  }

  AuthenticationState copyWith({
    User? user,
    String? error,
    AuthenticationStatus? authenticationStatus,
    String? token,
  }) {
    return AuthenticationState(
      user: user ?? this.user,
      error: error ?? this.error,
      authenticationStatus: authenticationStatus ?? this.authenticationStatus,
      token: token ?? this.token,
    );
  }

  bool isLoggedIn() {
    return user != null && token != null;
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user?.toMap(), // Convert user to map
      'error': error,
      'authenticationStatus':
          authenticationStatus.toString(), // Convert enum to string
      'token': token,
    };
  }

  factory AuthenticationState.fromMap(Map<String, dynamic> map) {
    return AuthenticationState(
      user: User.fromMap(map['user']), // Convert user from map
      error: map['error'],
      token: map['token'],
      authenticationStatus: _parseAuthenticationStatus(
          map['authenticationStatus']), // Parse enum from string
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthenticationState.fromJson(String source) =>
      AuthenticationState.fromMap(json.decode(source));

  static AuthenticationStatus _parseAuthenticationStatus(String status) {
    switch (status) {
      case 'AuthenticationStatus.initial':
        return AuthenticationStatus.initial;
      case 'AuthenticationStatus.loading':
        return AuthenticationStatus.loading;
      case 'AuthenticationStatus.successLogin':
        return AuthenticationStatus.successLogin;
      case 'AuthenticationStatus.failureLogin':
        return AuthenticationStatus.failureLogin;
      case 'AuthenticationStatus.updateSuccess':
        return AuthenticationStatus.updateSuccess;
      case 'AuthenticationStatus.updateFailure':
        return AuthenticationStatus.updateFailure;
      case 'AuthenticationStatus.successLogout':
        return AuthenticationStatus.successLogout;
      default:
        throw Exception('Invalid authentication status');
    }
  }
}
