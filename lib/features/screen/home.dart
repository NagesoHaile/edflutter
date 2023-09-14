import 'package:edir/core/constants/colors.dart';
import 'package:edir/features/screen/tabs/home_tab.dart';
import 'package:edir/features/screen/tabs/notification_tab.dart';
import 'package:edir/features/screen/tabs/profile_tab.dart';
import 'package:edir/features/services/sign_in_service.dart';
import 'package:flutter/material.dart';
import 'package:edir/core/controllers/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatefulWidget {
  Home({super.key});
  static const String routeName = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeTab(),
    NotificationTab(),
    ProfileTab(),
  ];
  @override
  Widget build(BuildContext context) {
    final username = Get.arguments; // Retrieve the passed username

    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.grey.withOpacity(.2),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: GNav(
              rippleColor: Colors.grey[800]!,
              hoverColor: Colors.grey[100]!,
              gap: 2,

              activeColor: AppColors.primaryColor,
              duration: const Duration(microseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              // color: Colors.grey,
              iconSize: 24,
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              style: GnavStyle.google,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.notifications,
                  text: 'Notifications',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                )
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
