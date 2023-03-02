import 'package:flutter/material.dart';
import 'package:swc_front/pages/login_page.dart';
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
        ),
        drawer: Drawer(
          backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: const <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(216, 243, 89, 89),
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()),
                    );
                },
                title: Text('Listar anuncios'),
                leading: Icon(Icons.post_add_outlined),
                iconColor: Colors.red,
                textColor: Color.fromARGB(215, 255, 255, 255),
              ),
              ListTile(
                title: Text('Crear anuncio'),
                leading: Icon(Icons.announcement_outlined),
                iconColor: Colors.red,
                textColor: Color.fromARGB(215, 255, 255, 255),
              ),
              ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings),
                iconColor: Colors.red,
                textColor: Color.fromARGB(215, 255, 255, 255),
              ),
            ],
          ),
        ),
      );
    });
  }
}
