import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';
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
    return BlurryContainer(
      // elevation: 0,
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      blur: 20,
      color: const Color.fromRGBO(0, 0, 0, 0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: GNav(
          selectedIndex: _selectedIndex,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          color: Colors.grey,
          activeColor: const Color(0xFFFF0000),
          // tabBackgroundColor: const Color(0xFFFF0000),
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
                Navigator.pushNamed(context, Routes.createAdvertPage);
                break;
              case 2:
                Navigator.pushNamed(context, Routes.loginPage);
                break;
              case 3:
                Navigator.pushNamed(context, Routes.editProfile);
                break;
            }
          },
          tabs: const [
            GButton(
              iconSize: 30,
              icon: CupertinoIcons.house_alt,
              // text: 'Home',
            ),
            GButton(
              iconSize: 30,
              icon: CupertinoIcons.suit_heart,
              // text: 'Likes',
            ),
            GButton(
              iconSize: 30,
              icon: CupertinoIcons.square_stack_3d_down_right,
              // text: 'Search',
            ),
            GButton(
              iconSize: 30,
              icon: CupertinoIcons.person_badge_plus,
              // text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
