import 'package:flutter/material.dart';
import 'package:swc_front/pages/index_page.dart';
import 'package:swc_front/pages/login_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Slut for Cash'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const LoginPage();
            }));
          },
          icon: const Icon(Icons.login),
          color: Colors.black,
        )
      ],
      backgroundColor: const Color.fromARGB(216, 243, 89, 89),
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
    );
  }
}
