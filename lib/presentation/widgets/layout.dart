import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/widgets/utils/bottom_menu.dart';
import 'package:swc_front/presentation/widgets/utils/bottom_sheet_menu.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../router/app_router.dart';

class Layout extends StatelessWidget {
  final Widget content;
  const Layout({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');
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
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(216, 243, 89, 89),
                  ),
                  child: Center(
                    child: TextView(
                      text: t.welcomeTitleLinkText,
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),

                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Routes.indexPage);
                  },
                  title: TextView(text: t.listAdvertLinkText),
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
                    title: TextView(text: t.createAdvertLinkText),
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
                    title: TextView(text: t.editButtonLinkText),
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
