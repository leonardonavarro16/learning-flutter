import 'package:flutter/material.dart';
import 'package:swc_front/widgets/nav_bar.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Scaffold(
          body: Container(
            color: Colors.black,
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: content,
          ),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(constraints.maxHeight * 0.075),
            child: const NavBar(),
          ));
    });
  }
}
