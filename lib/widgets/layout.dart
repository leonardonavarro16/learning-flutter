import 'dart:html';

import 'package:flutter/material.dart';
import 'package:swc_front/widgets/nav_bar.dart';

class Layout extends StatelessWidget {
  const Layout({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: NavBar(),
    ));
  }
}
