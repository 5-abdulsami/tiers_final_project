import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:tiers_final_project/res/color.dart';
import 'package:tiers_final_project/view/dashboard/profile/profile_screen.dart';
import 'package:tiers_final_project/view/dashboard/users/users_list_screen.dart';

import 'home/home_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      const UsersListScreen(),
      const ProfileScreen(),
    ];
  }

  FirebaseAuth auth = FirebaseAuth.instance;

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.home,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: const Icon(
          Icons.home,
          color: AppColors.grayColor,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.list_alt,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: const Icon(
          Icons.list,
          color: AppColors.grayColor,
        ),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(
          Icons.person,
        ),
        activeColorPrimary: AppColors.primaryIconColor,
        inactiveIcon: const Icon(
          Icons.person,
          color: AppColors.grayColor,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PersistentTabView(
        context,
        screens: _buildScreens(),
        items: _navBarItems(),
        controller: controller,
        backgroundColor: Colors.white,
        decoration: NavBarDecoration(
          border:
              Border(top: BorderSide(color: AppColors.grayColor, width: 0.5)),
        ),
        navBarStyle: NavBarStyle.style12,
      ),
    );
  }
}
