import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swc_front/logic/cubits/adverts.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:swc_front/presentation/widgets/utils/advert_search_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swc_front/presentation/widgets/utils/text_view.dart';

import '../../data/models/user.dart';

class Layout extends StatelessWidget {
  final String? searchText;
  final Widget content;
  const Layout({Key? key, required this.content, this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = context.watch<AuthenticationCubit>().state.user;
    String? token = context.read<AuthenticationCubit>().state.token;

    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    AppLocalizations? t = AppLocalizations.of(context);
    if (t == null) throw Exception('AppLocalizations not found');

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Scaffold(
          drawer: Container(
            width: constraints.maxWidth * 0.22,
            child: Drawer(
              backgroundColor: Colors.black,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.only(
                          right: 10, bottom: 10, left: 10, top: 30),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: DrawerHeader(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                            ),
                            child: SvgPicture.asset(
                              'assets/Logo blanco.svg',
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: const Color.fromARGB(255, 20, 20, 20),
                          child: ListTile(
                            leading: const Icon(
                              CupertinoIcons.house_alt,
                              color: Color(0xFFFF0000),
                            ),
                            title: const TextView(
                                text: 'Home',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.indexPage);
                            },
                          ),
                        ),
                        SizedBox(height: isLogged ? 5 : 0),
                        if (isLogged)
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: const Color.fromARGB(255, 20, 20, 20),
                            child: ListTile(
                              leading: const Icon(
                                CupertinoIcons.suit_heart,
                                color: Color(0xFFFF0000),
                              ),
                              title: const TextView(
                                  text: 'My fav Adverts',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              onTap: () {
                                !isLogged
                                    ? Navigator.pushReplacementNamed(
                                        context, Routes.loginPage)
                                    : Navigator.pushReplacementNamed(
                                        context, Routes.favoritesPage);
                              },
                            ),
                          ),
                        const SizedBox(height: 5),
                        if (isLogged)
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: const Color.fromARGB(255, 20, 20, 20),
                            child: ListTile(
                              leading: const Icon(
                                CupertinoIcons.add_circled_solid,
                                color: Color(0xFFFF0000),
                              ),
                              title: const TextView(
                                  text: 'add a new advert',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, Routes.createAdvertPage);
                              },
                            ),
                          ),
                        SizedBox(height: isLogged ? 5 : 0),
                        if (isLogged)
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            color: const Color.fromARGB(255, 20, 20, 20),
                            child: ListTile(
                                leading: const Icon(
                                  CupertinoIcons.square_stack_3d_down_right,
                                  color: Color(0xFFFF0000),
                                ),
                                title: const TextView(
                                    text: 'My adverts',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.myAdsPage);
                                }),
                          ),
                        const SizedBox(height: 5),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: const Color.fromARGB(255, 20, 20, 20),
                          child: ListTile(
                              leading: const Icon(
                                CupertinoIcons.person_badge_plus,
                                color: Color(0xFFFF0000),
                              ),
                              title: const TextView(
                                  text: 'My profile',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              onTap: () {
                                isLogged
                                    ? Navigator.pushReplacementNamed(
                                        context, Routes.editProfile)
                                    : Navigator.pushReplacementNamed(
                                        context, Routes.loginPage);
                                ;
                              }),
                        ),
                      ],
                    ),
                  ),
                  if (!isLogged)
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: !isLogged ? 20 : 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.green,
                        child: ListTile(
                            title: const TextView(
                                textAlign: TextAlign.center,
                                text: 'Log In',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, Routes.loginPage);
                            }),
                      ),
                    ),
                  if (isLogged)
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, bottom: isLogged ? 20 : 0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: const Color(0xFFFF0000),
                        child: ListTile(
                            title: const TextView(
                                textAlign: TextAlign.center,
                                text: 'Log Out',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                            onTap: () {
                              BlocProvider.of<AuthenticationCubit>(context)
                                  .logout();
                              Navigator.pushReplacementNamed(
                                  context, Routes.indexPage);
                            }),
                      ),
                    ),
                ],
              ),
            ),
          ),
          //! APPBAR ---------------------------------------------------------- X
          appBar: AppBar(
            centerTitle: true,
            title: Container(
              width: constraints.maxWidth * .55,
              child: AdvertSearchField(
                searchText: searchText,
                onChange: (value, shouldSearch) {
                  if (value.length >= 3) {
                    context
                        .read<AdvertsCubit>()
                        .fetchAdverts(token, searchText: value);
                  } else if (value.isEmpty) {
                    context.read<AdvertsCubit>().fetchAdverts(token);
                  }
                },
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, Routes.indexPage);
                },
                icon: const Icon(
                  CupertinoIcons.home,
                  size: 25,
                  color: Colors.white,
                ),
              ),
              !isLogged
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: IconButton(
                        onPressed: () {
                          !isLogged
                              ? Navigator.pushReplacementNamed(
                                  context, Routes.loginPage)
                              : Navigator.pushReplacementNamed(
                                  context, Routes.editProfile);
                        },
                        icon: const Icon(
                          CupertinoIcons.person_crop_circle,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: InkWell(
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(currentUser!.image!),
                        ),
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes.editProfile),
                      ),
                    ),
            ],
            toolbarHeight: 60,
            backgroundColor: Color.fromARGB(255, 11, 11, 11),
          ),
          //! APPBAR ---------------------------------------------------------- X
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
          // bottomNavigationBar: BottomNavigator(),
        );
      },
    );
  }
}
