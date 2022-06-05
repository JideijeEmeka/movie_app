import 'package:flutter/material.dart';
import 'package:movie_app/views/downloads_view.dart';
import 'package:movie_app/views/home_view.dart';
import 'package:movie_app/views/series_view.dart';
import 'package:movie_app/widgets/nav_bar_items.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  List<Widget> screens = const [
    HomeView(),
    SeriesView(),
    DownloadsView()
  ];

  late PersistentTabController _persistentTabController;
  final int _currentIndex = 0;

  @override
  void initState() {
    _persistentTabController =
        PersistentTabController(initialIndex: _currentIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _persistentTabController,
      screens: screens,
      items: navBarsItems(),
      confineInSafeArea: false,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0),
        colorBehindNavBar: Colors.white),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.fastOutSlowIn,
        duration: Duration(milliseconds: 200)),
      navBarStyle: NavBarStyle.style9,
    );
  }
}

