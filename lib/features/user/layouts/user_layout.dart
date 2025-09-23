import 'dart:ui';

import 'package:beclean/core/view_models/auth_view_model.dart';
import 'package:beclean/core/view_models/mutation_view_model.dart';
import 'package:beclean/core/view_models/schedule_view_model.dart';
import 'package:beclean/features/user/product/view_models/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home/views/user_home_page.dart';
import '../activity/views/activity_page.dart';
import '../profile/views/profile_page.dart';
// import 'product_page.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    UserHomePage(),
    // ProductPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  void _changeIndex(int index) {
    setState(() => _selectedIndex = index);

    if (index == 2) {
      context.read<AuthViewModel>().getProfile();
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProductViewModel>().getProducts();
    context.read<ScheduleViewModel>().getSchedule();
    context.read<MutationViewModel>().getActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: _pages[_selectedIndex],
      bottomNavigationBar: ClipRRect(
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(20.0),
        //   topRight: Radius.circular(20.0),
        // ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70.0, // Atur ketinggian di sini
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(20.0),
              //   topRight: Radius.circular(20.0),
              // ),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: const Color.fromARGB(255, 23, 87, 14),
              // unselectedItemColor: const Color.fromARGB(255, 15, 195, 30),
              showSelectedLabels: true, // sembunyikan label saat aktif
              showUnselectedLabels: false,
              onTap: _changeIndex,
              backgroundColor: Colors.transparent,
              elevation: 0,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/home.png',
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                  ),
                  label: 'Beranda',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.change_circle_rounded),
                //   label: 'Pickup',
                // ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/checklist.png',
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                  ),
                  label: 'Mutasi',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/images/profile.png',
                    width: 28,
                    height: 28,
                    alignment: Alignment.center,
                  ),

                  label: 'Profil',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
