import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/authentication.dart';
import '../../data/models/user.dart';
import '../../data/repositories/current_user_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repo = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationState.initial());

  Future<void> fetchCurrentUser() async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      User user = await _repo.fetch();
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.success, user: user));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'error de usuario'));
    }
  }

  Future<void> create(User user, String password) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      User newUser = await _repo.create(user, password);
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.success, user: newUser));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'Error creating the user'));
    }
  }

  Future<void> update(User user) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      User updatedUser = await _repo.update(user);
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.success,
          user: updatedUser));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'Error updating the user'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      String token = await _repo.login(email, password);
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.success,
        token: token,
      ));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: 'login failure'));
    }
  }
}
