import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter/cupertino.dart';

import 'package:swc_front/presentation/router/app_router.dart';

class AppleMusicBottomSheet extends StatefulWidget {
  @override
  _AppleMusicBottomSheetState createState() => _AppleMusicBottomSheetState();
}

class _AppleMusicBottomSheetState extends State<AppleMusicBottomSheet> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          selectedIndex: _selectedIndex,
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          color: Colors.red,
          activeColor: Colors.white,
          tabBackgroundColor: const Color(0xFFFF0000),
          padding: const EdgeInsets.all(16),
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
              icon: Icons.home,
              // text: 'Home',
            ),
            GButton(
              icon: Icons.favorite_border,
              // text: 'Likes',
            ),
            GButton(
              icon: Icons.search,
              // text: 'Search',
            ),
            GButton(
              icon: CupertinoIcons.person_circle_fill,
              // text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
