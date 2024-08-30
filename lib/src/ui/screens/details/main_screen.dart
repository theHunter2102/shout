import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shout/src/navigation/app_navigator.dart';
import 'package:shout/src/ui/screens/details/bookmark_screen.dart';
import 'package:shout/src/ui/screens/details/category_screen.dart';
import 'package:shout/src/ui/screens/details/home_screen.dart';
import 'package:shout/src/ui/screens/details/profile/profile_screen.dart';
import '../../../config/constants.dart';

class MainScreen extends StatefulWidget {
  final int index;
  const MainScreen({super.key, this.index = 0});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex;
  final BookmarkScreen _bookmarkScreen = BookmarkScreen();

  final List<Widget> _screens = [
    HomeScreen(),
    CategoryScreen(),
    const BookmarkScreen(),
    ProfileScreen(),
  ];

  @override
  void  initState(){
    super.initState();
    _currentIndex = widget.index;
  }

  void _refreshTab(int index){
    if(index != _currentIndex){
      setState(() {
        _currentIndex = index;
      });
      if(_currentIndex == 2){
        // _bookmarkKey.currentState?.refresh();
        // final BookmarkScreenState? bookmarkState = _screens[2].key as BookmarkScreenState?;
        // bookmarkState?.refresh();
        // AppNavigator.navigateToScreen(context, const BookmarkScreen());
        AppNavigator.navigateToScreen(context, const MainScreen(index: 2,));
      }
      if(_currentIndex == 1){
        AppNavigator.navigateToScreen(context, const MainScreen(index: 1,));
      }
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: _currentIndex,
            children: _screens,
          ),
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




            onTap: _refreshTab,
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
    );
  }
}