import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

List<PersistentBottomNavBarItem> navBarsItems() {
  return [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: ("Home"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.rectangle_3_offgrid_fill),
      title: ("Series"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.video_camera),
      title: ("Coming Soon"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(CupertinoIcons.cloud_download_fill),
      title: ("Downloads"),
      activeColorPrimary: CupertinoColors.white,
      inactiveColorPrimary: CupertinoColors.systemGrey,
    ),
  ];
}