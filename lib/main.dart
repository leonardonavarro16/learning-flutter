import 'package:flutter/material.dart';

void main() => runApp(const SwcApp());

class SwcApp extends StatelessWidget {
  const SwcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue), home: const IndexPage());
  }
}

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Container(
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.1,
                color: Colors.blue,
                child: const Center(child: Text('Header')),
              ),
              Container(
                width: screenSize.width * 0.5,
                color: Colors.green,
                height: screenSize.height * 0.1,
                child: const Center(
                  child: Text('navbar'),
                ),
              ),
            ],
          ),
          Container(
            height: screenSize.height * 0.8,
            color: Colors.yellow,
          ),
          Container(
              width: screenSize.width,
              height: screenSize.height * 0.1,
              color: Colors.black,
              child: const Center(
                child: Text('footer', style: TextStyle(color: Colors.white)),
              )),
        ],
      ),
    );
  }
}

class Changecolor extends StatefulWidget {
  const Changecolor({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement  createState
    throw UnimplementedError();
  }
}
