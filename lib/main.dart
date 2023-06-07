import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'presentation/router/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(SwcApp());
}

class SwcApp extends StatelessWidget {
  final AuthenticationCubit authenticationCubit = AuthenticationCubit();
  SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppRouter appRouter =
        AppRouter(authenticationCubit: authenticationCubit);
    return BlocProvider.value(
      value: authenticationCubit,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.red, // Cambia el color del cursor aquí
          ),
          primaryColor: const Color(0xFFFF0000),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
