import 'dart:ui';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'activity_page.dart';
import 'profile_page.dart';
// import 'product_page.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    // ProductPage(),
    ActivityPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
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
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
              // borderRadius: const BorderRadius.only(
              //   topLeft: Radius.circular(20.0),
              //   topRight: Radius.circular(20.0),
              // ),
            ),
            child: BottomNavigationBar(
              currentIndex: _selectedIndex,
              selectedItemColor: Color.fromARGB(255, 23, 87, 14),
              // unselectedItemColor: const Color.fromARGB(255, 15, 195, 30),
              showSelectedLabels: true, // sembunyikan label saat aktif
              showUnselectedLabels: false,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
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
