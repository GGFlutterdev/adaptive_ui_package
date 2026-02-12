import 'package:adaptive_ui/adaptive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

/// Item per la bottom navigation bar
class AdaptiveBottomNavItem {
  final Widget icon;
  final Widget? activeIcon;
  final String label;

  const AdaptiveBottomNavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

/// Bottom Navigation Bar adattiva (BottomNavigationBar / CupertinoTabBar)
class AdaptiveBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AdaptiveBottomNavItem> items;
  final Color? backgroundColor;
  final Color? activeColor;

  const AdaptiveBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor,
    this.activeColor,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoTabBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor,
        activeColor: activeColor ?? CupertinoColors.activeBlue,
        items: items
            .map((item) => BottomNavigationBarItem(
                  icon: item.icon,
                  activeIcon: item.activeIcon ?? item.icon,
                  label: item.label,
                ))
            .toList(),
      );
    } else {
      return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        backgroundColor: backgroundColor,
        selectedItemColor: activeColor,
        items: items
            .map((item) => BottomNavigationBarItem(
                  icon: item.icon,
                  activeIcon: item.activeIcon ?? item.icon,
                  label: item.label,
                ))
            .toList(),
      );
    }
  }
}

/// Tab Scaffold adattivo per gestire pagine con tab
class AdaptiveTabScaffold extends StatelessWidget {
  final List<Widget> children;
  final List<AdaptiveBottomNavItem> tabItems;
  final Color? backgroundColor;
  final Color? activeColor;

  const AdaptiveTabScaffold({
    Key? key,
    required this.children,
    required this.tabItems,
    this.backgroundColor,
    this.activeColor,
  }) : super(key: key);

  static bool get isIOS => Platform.isIOS;

  @override
  Widget build(BuildContext context) {
    if (isIOS) {
      return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          backgroundColor: backgroundColor,
          activeColor: activeColor ?? CupertinoColors.activeBlue,
          items: tabItems
              .map((item) => BottomNavigationBarItem(
                    icon: item.icon,
                    activeIcon: item.activeIcon ?? item.icon,
                    label: item.label,
                  ))
              .toList(),
        ),
        tabBuilder: (context, index) {
          return children[index];
        },
      );
    } else {
      return _MaterialTabScaffold(
        children: children,
        tabItems: tabItems,
        backgroundColor: backgroundColor,
        activeColor: activeColor,
      );
    }
  }
}

/// Implementazione Material per il tab scaffold
class _MaterialTabScaffold extends StatefulWidget {
  final List<Widget> children;
  final List<AdaptiveBottomNavItem> tabItems;
  final Color? backgroundColor;
  final Color? activeColor;

  const _MaterialTabScaffold({
    required this.children,
    required this.tabItems,
    this.backgroundColor,
    this.activeColor,
  });

  @override
  State<_MaterialTabScaffold> createState() => _MaterialTabScaffoldState();
}

class _MaterialTabScaffoldState extends State<_MaterialTabScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: widget.children,
      ),
      bottomNavigationBar: AdaptiveBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: widget.backgroundColor,
        activeColor: widget.activeColor,
        items: widget.tabItems,
      ),
    );
  }
}
