import 'package:flutter/material.dart';
import 'pages/create_advert_page.dart';

void main() => runApp(const SwcApp());

class SwcApp extends StatelessWidget {
  const SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const CreateAdvertPage());
  }
}
