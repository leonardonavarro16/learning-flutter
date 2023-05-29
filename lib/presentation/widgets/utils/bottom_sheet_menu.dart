import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:swc_front/logic/cubits/authentication_cubit.dart';
import 'package:swc_front/presentation/router/app_router.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class AppleMusicBottomSheet extends StatefulWidget {
  @override
  _AppleMusicBottomSheetState createState() => _AppleMusicBottomSheetState();
}

class _AppleMusicBottomSheetState extends State<AppleMusicBottomSheet> {
  int _selectedIndex = 0;

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
          selectedIndex: _selectedIndex,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          color: Colors.grey,
          activeColor: const Color(0xFFFF0000),
          padding: const EdgeInsets.all(5),
          gap: 8,
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });

            switch (index) {
              case 0:
                Navigator.pushNamed(context, Routes.indexPage);
                break;
              case 1:
                !isLogged
                    ? Navigator.pushNamed(context, Routes.loginPage)
                    : Navigator.pushNamed(context, Routes.createAdvertPage);
                break;
              case 2:
                Navigator.pushNamed(context, Routes.loginPage);
                break;
              case 3:
                !isLogged
                    ? Navigator.pushNamed(context, Routes.loginPage)
                    : Navigator.pushNamed(context, Routes.editProfile);

                break;
            }
          },
          tabs: [
            const GButton(
              iconSize: 30,
              icon: CupertinoIcons.house_alt,
            ),
            if (isLogged)
              const GButton(
                iconSize: 30,
                icon: CupertinoIcons.suit_heart,
              ),
            if (isLogged)
              const GButton(
                iconSize: 30,
                icon: CupertinoIcons.square_stack_3d_down_right,
              ),
            const GButton(
              iconSize: 30,
              icon: CupertinoIcons.person_badge_plus,
            ),
          ],
        ),
      ),
    );
  }
}
