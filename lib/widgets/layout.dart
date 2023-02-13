import 'package:flutter/material.dart';
import 'package:swc_front/widgets/nav_bar.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: Colors.black,
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: content,
          );
        }),
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: NavBar(),
        ));
  }
}
