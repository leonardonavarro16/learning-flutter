import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swc_front/presentation/pages/create_advert_page.dart';
import 'package:swc_front/presentation/pages/default_page.dart';
import 'package:swc_front/presentation/pages/index_page.dart';
import 'package:swc_front/presentation/pages/login_page.dart';
import 'package:swc_front/presentation/pages/registration_page.dart';

import '../pages/edit_profile.dart';

class Routes {
  static const String index_page = '/home_page';
  static const String edit_profile = '/edit_profile';
  static const String login_page = '/login_page';
  static const String create_advert_page = '/create_advert';
  static const String registration_page = '/registration_page';
}

class AppNavigatorObserver extends NavigatorObserver {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      // index_page
      case Routes.index_page:
        return MaterialPageRoute(builder: (_) => const IndexPage());
      // edit_profile
      case Routes.edit_profile:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      // login_page
      case Routes.login_page:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      // create_advert_page
      case Routes.create_advert_page:
        return MaterialPageRoute(builder: (_) => const CreateAdvertPage());
      // registration_page
      case Routes.registration_page:
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      // default case
      default:
        return MaterialPageRoute(builder: (_) => const IndexPage());
    }
  }

  static Route<dynamic> onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) => const NotFoundPage());
  }
}
