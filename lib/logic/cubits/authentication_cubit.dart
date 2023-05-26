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
    print('holi');
    try {
      Map<String, dynamic> response = await _repo.login(email, password);
      print(response['user']);
      emit(state.copyWith(
        authenticationStatus: AuthenticationStatus.success,
        token: response['token'],
        user: response['user'],
      ));
    } catch (error) {
      emit(state.copyWith(
          authenticationStatus: AuthenticationStatus.failure,
          error: error.toString()));
    }
  }

  bool isLogged() {
    return state.token != null && state.user != null;
  }
}
