import 'package:flutter/material.dart';
import 'package:swc_front/pages/create_advert_page.dart';
import 'package:swc_front/pages/index_page.dart';
import 'package:swc_front/pages/login_page.dart';
import 'package:swc_front/widgets/nav_bar.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({Key? key, required this.content}) : super(key: key);

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
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(216, 243, 89, 89),
                  ),
                  child: Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      'Bienvenido a Sluts for Cash!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IndexPage()),
                    );
                  },
                  title: const Text('Listar anuncios'),
                  leading: const Icon(Icons.post_add_outlined),
                  iconColor: Colors.red,
                  textColor: const Color.fromARGB(215, 255, 255, 255),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdvertFormPage()),
                    );
                    // Handle onTap for creating anuncio
                  },
                  title: const Text('Crear anuncio'),
                  leading: const Icon(Icons.announcement_outlined),
                  iconColor: Colors.red,
                  textColor: const Color.fromARGB(215, 255, 255, 255),
                ),
                ListTile(
                  onTap: () {
                    // Handle onTap for settings
                  },
                  title: const Text('Settings'),
                  leading: const Icon(Icons.settings),
                  iconColor: Colors.red,
                  textColor: const Color.fromARGB(215, 255, 255, 255),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
