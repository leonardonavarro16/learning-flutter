import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/data/models/user.dart';
import 'package:swc_front/logic/states/user.dart';
import 'package:swc_front/data/repositories/user.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository = UserRepository();

  UserCubit() : super(UserState.initial());

  Future<void> create(User user, String password) async {
    emit(state.copyWith(userStatus: UserStatus.loading));

    try {
      User newUser = await _userRepository.create(user, password);

      emit(state.copyWith(userStatus: UserStatus.createSuccess, user: newUser));
    } catch (error) {
      emit(state.copyWith(
          userStatus: UserStatus.createFailure, error: error.toString()));
    }
  }
}
