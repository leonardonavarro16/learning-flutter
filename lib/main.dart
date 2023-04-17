import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/user.dart';

import 'presentation/router/app_router.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(SwcApp());
}

class SwcApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthenticationCubit(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        onGenerateRoute: _appRouter.onGenerateRoute,
      ),
    );
  }
}
