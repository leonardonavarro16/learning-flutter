import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swc_front/logic/cubits/navigation.dart';
import 'package:swc_front/logic/cubits/user.dart';
import 'package:swc_front/presentation/pages/default_page.dart';
import 'package:swc_front/presentation/pages/fav_adverts_page.dart';
import 'package:swc_front/presentation/pages/index_page.dart';
import 'package:swc_front/presentation/pages/login_page.dart';
import 'package:swc_front/presentation/pages/registration_page.dart';

import '../../logic/cubits/adverts.dart';
import '../../logic/cubits/authentication_cubit.dart';
import '../pages/create_advert_page.dart';
import '../pages/edit_profile.dart';

class Routes {
  static const String indexPage = '/home-page';
  static const String editProfile = '/edit-profile';
  static const String loginPage = '/login-page';
  static const String createAdvertPage = '/create-advert';
  static const String registrationPage = '/registration-page';
  static const String notFoundPage = '/not-found';
  static const String favoritesPage = '/favorites-page';
}

class AppRouter {
  final AdvertsCubit _advertsCubit = AdvertsCubit();
  final UserCubit _userCubit = UserCubit();
  final NavigationCubit _navigationCubit = NavigationCubit();
  final AuthenticationCubit authenticationCubit;

  AppRouter({required this.authenticationCubit});

  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.indexPage:
        _navigationCubit.setSelectedIndex(0);
        _advertsCubit.fetchAdverts(authenticationCubit.state.token);
        _advertsCubit.getAllAdTags(authenticationCubit.state.token);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _advertsCubit),
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const IndexPage(),
          ),
        );
      case Routes.favoritesPage:
        _navigationCubit.setSelectedIndex(1);
        _advertsCubit.fetchFavAdverts(authenticationCubit.state.token);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _advertsCubit),
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const FavAdvertsPage(),
          ),
        );
      case Routes.editProfile:
        _navigationCubit.setSelectedIndex(4);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const EditProfilePage(),
          ),
        );

      case Routes.loginPage:
        _navigationCubit.setSelectedIndex(3);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const LoginPage(),
          ),
        );

      case Routes.createAdvertPage:
        _navigationCubit.setSelectedIndex(2);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _advertsCubit),
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const CreateAdvertPage(),
          ),
        );

      case Routes.registrationPage:
        _navigationCubit.setSelectedIndex(3);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _userCubit),
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const RegistrationPage(),
          ),
        );

      default:
        _navigationCubit.setSelectedIndex(0);
        _advertsCubit.getAllAdTags(authenticationCubit.state.token);
        _advertsCubit.fetchAdverts(authenticationCubit.state.token);
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: _advertsCubit),
              BlocProvider.value(value: _navigationCubit),
            ],
            child: const IndexPage(),
          ),
        );
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
