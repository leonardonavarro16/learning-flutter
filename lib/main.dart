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
              ChangeColor(
                text: 'Header',
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.1,
                color: Colors.blue,
              ),
              ChangeColor(
                text: 'Navbar',
                width: screenSize.width * 0.5,
                height: screenSize.height * 0.1,
                color: Colors.green,
              ),
            ],
          ),
          ChangeColor(
            text: 'Body',
            width: screenSize.width,
            height: screenSize.height * 0.8,
            color: Colors.yellow,
          ),
          ChangeColor(
            text: 'Footer',
            width: screenSize.width,
            height: screenSize.height * 0.1,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}

class ChangeColor extends StatefulWidget {
  final double width;
  final double height;
  final String text;
  Color color;

  ChangeColor({
    super.key, required this.width,
    required this.height, required this.color,
    required this.text,
  });

  @override
  State<StatefulWidget> createState() => ChangeColorState();
}

class ChangeColorState extends State<ChangeColor> {
  int count=0;
  List<Color> colors = [Colors.blue, Colors.green, Colors.yellow, Colors.black];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.color = colors[count % colors.length];
          count += 1;
        });
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.color,
        child: Center(
          child: Text(widget.text),
        ),
      )
    );
  }
}
