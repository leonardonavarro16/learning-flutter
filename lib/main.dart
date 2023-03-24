import 'package:flutter/material.dart';
import 'package:swc_front/presentation/pages/index_page.dart';

import 'presentation/router/app_router.dart';

void main() => runApp(SwcApp());

class SwcApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();
  SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: _appRouter.onGenerateRoute,
    );
  }
}
