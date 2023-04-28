import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppleMusicBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.6), // Ajustamos la opacidad a 0.7
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
          backgroundColor: Color.fromRGBO(0, 0, 0, 0),
          color: Colors.red,
          activeColor: Colors.white,
          tabBackgroundColor: Color(0xFFFF0000),
          padding: EdgeInsets.all(16),
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'Likes',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
