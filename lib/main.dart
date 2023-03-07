import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/states/current_user.dart';
import 'package:swc_front/pages/index_page.dart';

void main() => runApp(const SwcApp());

class SwcApp extends StatelessWidget {
  const SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => CurrentUserState(),
        child: MaterialApp(
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const IndexPage()));
  }
}
