import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/nav_bar.dart';
import 'package:swc_front/presentation/widgets/utils/bottom_sheet_menu.dart';
import 'package:swc_front/presentation/widgets/utils/wave_clipper.dart';

import '../router/app_router.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          extendBody: true,
          body: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Color(0xFFFF0000),
                ],
                begin: Alignment.center,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: ClipPath(
                    clipper: WaveClipperTwo(reverse: true),
                    child: Container(
                      height: constraints.maxHeight * 0.2,
                      width: constraints.maxWidth,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(255, 76, 5, 0),
                            Color(0xFFFF0000),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                ),
                content
              ],
            ),
          ),
          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(constraints.maxHeight * 0.075),
          //   child: const NavBar(),
          // ),
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
                    Navigator.pushReplacementNamed(context, Routes.indexPage);
                  },
                  title: const Text('Listar anuncios'),
                  leading: const Icon(Icons.post_add_outlined),
                  iconColor: Colors.red,
                  textColor: const Color.fromARGB(215, 255, 255, 255),
                ),
                if (isLogged)
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.createAdvertPage);
                    },
                    title: const Text('Crear anuncio'),
                    leading: const Icon(Icons.announcement_outlined),
                    iconColor: Colors.red,
                    textColor: const Color.fromARGB(215, 255, 255, 255),
                  ),
                // ListTile(
                //   onTap: () {
                //     Navigator.pushReplacementNamed(context, Routes.testingPage);
                //   },
                //   title: const Text('Testeo de página'),
                //   leading: const Icon(Icons.auto_fix_high),
                //   iconColor: Colors.blue,
                //   textColor: const Color.fromARGB(215, 255, 255, 255),
                // ),
                if (isLogged)
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.editProfile);
                      // Handle onTap for settings
                    },
                    title: const Text('Editar perfil'),
                    leading: const Icon(Icons.settings),
                    iconColor: Colors.red,
                    textColor: const Color.fromARGB(215, 255, 255, 255),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: AppleMusicBottomSheet(),
        );
      },
    );
  }
}
