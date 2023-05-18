import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:swc_front/presentation/router/app_router.dart';

class BottomMenu extends StatefulWidget {
  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreen() {
    return const [
      Text('Home'),
      Text('Likes'),
      Text('Add'),
      Text('My ads'),
      Text('profile'),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItem() {
    return [
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: const Color(0xFFFF0000),
        icon: const Icon(CupertinoIcons.house_alt),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: const Color(0xFFFF0000),
        icon: const Icon(CupertinoIcons.suit_heart),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: const Color(0xFFFF0000),
        icon: const Icon(CupertinoIcons.add),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: const Color(0xFFFF0000),
        icon: const Icon(CupertinoIcons.square_stack_3d_down_right),
      ),
      PersistentBottomNavBarItem(
        inactiveColorPrimary: Colors.grey,
        activeColorPrimary: const Color(0xFFFF0000),
        icon: const Icon(CupertinoIcons.person_badge_plus),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreen(),
      items: _navBarItem(),
      navBarStyle: NavBarStyle.style15,
      onItemSelected: (int index) {
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
          case 4:
            Navigator.pushNamed(context, Routes.registrationPage);
        }
      },
    );
  }
}
