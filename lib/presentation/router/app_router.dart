import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/pages/create_advert_page.dart';
import 'package:swc_front/presentation/pages/default_page.dart';
import 'package:swc_front/presentation/pages/index_page.dart';
import 'package:swc_front/presentation/pages/login_page.dart';
import 'package:swc_front/presentation/pages/registration_page.dart';

import '../../logic/cubits/adverts.dart';
import '../pages/edit_profile.dart';

class Routes {
  static const String indexPage = '/home-page';
  static const String editProfile = '/edit-profile';
  static const String loginPage = '/login-page';
  static const String createAdvertPage = '/create-advert';
  static const String registrationPage = '/registration-page';
}

class AppRouter {
  final AdvertsCubit _advertsCubit = AdvertsCubit();
  final AuthenticationCubit _authenticationCubit = AuthenticationCubit();

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.indexPage:
        _advertsCubit.fetchAdverts();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _advertsCubit, child: const IndexPage()));
      case Routes.editProfile:
        _authenticationCubit.fetchCurrentUser();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _authenticationCubit, child: const EditProfilePage()));
      case Routes.loginPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _authenticationCubit, child: const LoginPage()));

      case Routes.createAdvertPage:
        _authenticationCubit.fetchCurrentUser();
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider.value(
                    value: _advertsCubit,
                  ),
                  BlocProvider.value(value: _authenticationCubit)
                ], child: const CreateAdvertPage()));

      case Routes.registrationPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _authenticationCubit, child: const RegistrationPage()));
      default:
        _advertsCubit.fetchAdverts();
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                value: _advertsCubit, child: const IndexPage()));
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
