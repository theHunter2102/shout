import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/ui/screens/bookmark_screen.dart';
import 'package:shout/src/ui/screens/category_screen.dart';
import 'package:shout/src/ui/screens/home_screen.dart';
import 'package:shout/src/ui/screens/profile/profile_screen.dart';

import 'config/constants.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
              padding: const EdgeInsets.all(5),

              decoration: BoxDecoration(
              color:Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                  // bottom: Radius.circular(20),
                ),
                // color: Colors.white,
                border: Border.all(
                    color: const Color(0xFFACAFC3),
                    width: 0.5
                ),
              ),
            child: CupertinoTabBar(
              backgroundColor: Colors.white,
              border: Border.all(
                color: Colors.transparent,
                width: 0
              ),
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/home.svg',
                    color: _currentIndex == 0 ? AppConstants.purplePrimary : Colors.grey,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/category.svg',
                    color: _currentIndex == 1 ? AppConstants.purplePrimary : Colors.grey,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/bookmark.svg',
                    color: _currentIndex == 2 ? AppConstants.purplePrimary : Colors.grey,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/user.svg',
                    color: _currentIndex == 3 ? AppConstants.purplePrimary : Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      debugShowCheckedModeBanner: false,
      );
  }
}
