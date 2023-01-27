import 'package:flutter/material.dart';

void main() => runApp(const SwcApp());

class SwcApp extends StatelessWidget {
  const SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: IndexPage());
  }
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: screenSize.width * 0.25,
            height: screenSize.height * 0.25,
            color: Colors.green,
            child: const Text('Hola mundo'),
          ),
          Container(
            width: screenSize.width * 0.1,
            height: screenSize.height * 0.1,
            color: Colors.blue,
            child: const Text('Hola mundo'),
          )
        ],
      ),
    );
  }
}
