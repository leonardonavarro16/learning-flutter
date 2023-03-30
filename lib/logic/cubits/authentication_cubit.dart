import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/authentication.dart.dart';
import '../../data/models/user.dart';
import '../../data/repositories/current_user_repository.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final CurrentUserRepository _repo = CurrentUserRepository();

  AuthenticationCubit() : super(AuthenticationState.initial());

  Future<void> fetchCurrentUser() async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    try {
      User user = await _repo.fetch();
      emit(state.copyWith(userStatus: UserStatus.success, user: user));
    } catch (error) {
      emit(state.copyWith(
          userStatus: UserStatus.failure, error: 'error de usuario'));
    }
  }

  Future<void> update(User user) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    try {
      User updatedUser = await _repo.update(user);
      emit(state.copyWith(userStatus: UserStatus.success, user: updatedUser));
    } catch (error) {
      emit(state.copyWith(
          userStatus: UserStatus.failure,
          error: 'error al actualizar el usuario'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(state.copyWith(userStatus: UserStatus.loading));
    try {
      String token = await _repo.login(email, password);
      emit(state.copyWith(
        userStatus: UserStatus.success,
        token: token, // guardar el token en el estado del cubit
      ));
    } catch (error) {
      emit(state.copyWith(
          userStatus: UserStatus.failure, error: 'login failure'));
    }
  }
}
