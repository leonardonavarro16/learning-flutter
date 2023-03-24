import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/current_user.dart';
import '../../data/models/user.dart';
import '../../data/repositories/current_user_repository.dart';

class AuthenticationCubit extends Cubit<CurrentUserState> {
  final CurrentUserRepository _repo = CurrentUserRepository();
  AuthenticationCubit() : super(CurrentUserInitial());

  Future<void> fetchCurrentUser() async {
    User user = await _repo.fetch();
    emit(CurrentUserFetchSuccess(user: user));
  }

  Future<void> update(User user) async {
    User updatedUser = await _repo.update(user);
    emit(CurrentUserFetchSuccess(user: updatedUser));
  }
}
