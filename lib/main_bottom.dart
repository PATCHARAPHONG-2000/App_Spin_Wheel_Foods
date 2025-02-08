import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import 'screen/listfoode.dart';
import 'screen/profile.dart';
import 'screen/spinwheel_manual.dart';
import 'themes/colors.dart';

class MainBottom extends StatefulWidget {
  const MainBottom({super.key});

  @override
  State<MainBottom> createState() => _MainBottomState();
}

class _MainBottomState extends State<MainBottom> {
  final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  // ตัวแปรเก็บข้อมูลของ PersistentBottomNavBarItem
  final List<PersistentBottomNavBarItem> _navBarItems = [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.restaurant_menu),
      title: ("เมนูอาหาร"),
      activeColorPrimary: primary,
      inactiveColorPrimary: secondaryText,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.casino),
      title: ("วงล้อ"),
      activeColorPrimary: primary,
      inactiveColorPrimary: secondaryText,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: ("โปรไฟล์"),
      activeColorPrimary: primary,
      inactiveColorPrimary: secondaryText,
    ),
  ];

  List<Widget> _buildScreens() => [
        ListFood(
          title: _navBarItems[0].title ??
              'Default Title', // Provide a fallback if title is null
        ),
        SpinWheelManual(
          title: _navBarItems[1].title ?? 'Default Title',
        ),
        Profile(
          title: _navBarItems[2].title ?? 'Default Title',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems, // ใช้ _navBarItems ที่เก็บข้อมูลไว้
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: false,
        stateManagement: true,
        hideNavigationBarWhenKeyboardAppears: true,
        backgroundColor: icons,
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.circular(10.0),
          colorBehindNavBar: icons,
        ),
        navBarStyle: NavBarStyle.style1,
        navBarHeight: 60.0,
      ),
    );
  }
}
