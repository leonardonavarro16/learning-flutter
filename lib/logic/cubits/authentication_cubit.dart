import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/authentication.dart';
import '../../data/models/user.dart';
import '../../data/repositories/authentication_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repo = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationState.initial());

  Future<void> create(User user, String password) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      User newUser = await _repo.create(user, password);
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.success, user: newUser));
      await login(newUser.email, password);
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'Error creating the user'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      Map<String, dynamic> response = await _repo.login(email, password);
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.success,
        token: response['token'],
        user: response['user'],
      ));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'login failure'));
    }
  }

  bool isLogged() {
    return state.token != null && state.user != null;
  }
}
