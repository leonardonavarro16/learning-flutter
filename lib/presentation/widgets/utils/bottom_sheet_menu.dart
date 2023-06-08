import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/logic/cubits/navigation.dart';
import 'package:swc_front/presentation/pages/fav_advert_page.dart';
import 'package:swc_front/presentation/pages/fav_advert_page.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  @override
  Widget build(BuildContext context) {
    bool isLogged = context.watch<AuthenticationCubit>().isLogged();
    return BlurryContainer(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35),
        topRight: Radius.circular(35),
      ),
      blur: 20,
      color: const Color.fromRGBO(0, 0, 0, 0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: GNav(
          mainAxisAlignment: !isLogged
              ? MainAxisAlignment.spaceEvenly
              : MainAxisAlignment.spaceBetween,
          selectedIndex: context.watch<NavigationCubit>().state.selectedIndex,
          color: Colors.grey,
          activeColor: const Color(0xFFFF0000),
          padding: const EdgeInsets.all(5),
          gap: 8,
          onTabChange: (index) {
            context.read<NavigationCubit>().setSelectedIndex(index);
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, Routes.indexPage);
                break;
              case 1:
                !isLogged
                    ? Navigator.pushReplacementNamed(context, Routes.loginPage)
                    : Navigator.pushReplacementNamed(
                        context, Routes.createAdvertPage);
                break;
              case 2:
                Navigator.pushReplacementNamed(context, Routes.favoritesPage);
                break;
              case 3:
                // !isLogged
                //     ? Navigator.pushReplacementNamed(context, Routes.loginPage)
                Navigator.pushReplacementNamed(context, Routes.editProfile);

                break;

              case 4:
                Navigator.pushReplacementNamed(context, Routes.favoritesPage);

                break;
            }
          },
          tabs: [
            const GButton(
              // text: 'Home',
              iconSize: 30,
              icon: CupertinoIcons.house_alt,
            ),
            if (isLogged)
              const GButton(
                iconSize: 30,
                icon: CupertinoIcons.suit_heart,
              ),
            // if (isLogged)
            // GButton(
            //   iconSize: 42.5,
            //   icon: CupertinoIcons.add_circled_solid,
            // ),
            if (isLogged)
              const GButton(
                iconSize: 30,
                icon: CupertinoIcons.square_stack_3d_down_right,
              ),
            const GButton(
              // text: 'Perfil',
              iconSize: 30,
              icon: CupertinoIcons.person_badge_plus,
            ),
            if (isLogged)
              const GButton(
                // text: 'Perfil',
                iconSize: 30,
                icon: CupertinoIcons.airplane,
              ),
          ],
        ),
      ),
    );
  }
}
