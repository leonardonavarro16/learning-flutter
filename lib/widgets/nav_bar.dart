import 'package:flutter/material.dart';
import 'package:swc_front/pages/login_page.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Center(
        child: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const LoginPage();
            }));
          },
          icon: const Icon(Icons.login),
          color: Colors.black,
        ),
      ),
      title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Home',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      backgroundColor: const Color.fromARGB(216, 243, 89, 89),
    );
  }
}
