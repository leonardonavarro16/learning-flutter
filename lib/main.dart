import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swc_front/pages/index_page.dart';

import 'states/current_user.dart';
import 'states/adverts.dart';

void main() => runApp(const SwcApp());

class SwcApp extends StatelessWidget {
  const SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CurrentUserState()),
        ChangeNotifierProvider(create: (_) => AdvertsState()),
      ],
      child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const IndexPage()),
    );
  }
}
