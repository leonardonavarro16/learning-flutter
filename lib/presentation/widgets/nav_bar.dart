import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import '../router/app_router.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const TextView(text: 'Slut for Cash'),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.loginPage);
          },
          icon: const Icon(Icons.login),
          color: Colors.black,
        )
      ],
      backgroundColor: const Color(0xFFFF0000),
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
      // Agrega el BackdropFilter
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.5),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.5, 1],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
