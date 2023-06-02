import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/states/nagivation.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(NavigationState.initial());

  void setSelectedIndex(int index) {
    emit(state.copyWith(selectedIndex: index));
  }
}
