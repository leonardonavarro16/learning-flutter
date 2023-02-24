import 'package:flutter/material.dart';
import 'package:swc_front/pages/index_page.dart';
import 'package:swc_front/pages/login_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Container(
        color: const Color.fromARGB(216, 243, 89, 89),
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        height: constraints.maxHeight,
        width: constraints.maxWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const IndexPage()),
                );
              },
              child: const Text(
                'Slut for Cash',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.login),
              color: Colors.black,
            ),
          ],
        ),
      );
    });
  }
}
