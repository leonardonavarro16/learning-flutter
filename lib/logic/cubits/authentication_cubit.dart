import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/authentication.dart';
import '../../data/models/user.dart';
import '../../data/repositories/authentication_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthenticationRepository _repo = AuthenticationRepository();

  AuthenticationCubit() : super(AuthenticationState.initial());

  void setUser(User user) {
    emit(state.copyWith(user: user));
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      Map<String, dynamic> response = await _repo.login(email, password);
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.successLogin,
        token: response['token'],
        user: response['user'],
      ));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failureLogin,
          error: error.toString()));
    }
  }

  Future<void> update(User updatedUser) async {
    emit(state.copyWith(authenticationStatus: AuthenticationStatus.loading));
    try {
      User user = await _repo.update(updatedUser, state.token!);
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.updateSuccess,
        user: user,
      ));
    } catch (error) {
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.updateFailure,
        error: error.toString(),
      ));
    }
  }

  bool isLogged() {
    return state.token != null && state.user != null;
  }
}
