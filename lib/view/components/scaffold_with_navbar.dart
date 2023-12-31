import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flutter/route.dart';
import 'dart:developer' as developer;

class ScaffoldWithNavBar extends StatefulWidget {
  String location;
  final Widget child;

  ScaffoldWithNavBar({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  State<ScaffoldWithNavBar> createState() => _ScaffoldWithNavBarState();
}

class _ScaffoldWithNavBarState extends State<ScaffoldWithNavBar> {
  int _currentIndex = 0;

  static const List<MyCustomBottomNavBarItem> tabs = [
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home),
      label: 'HOME',
      initialLocation: '/',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.ac_unit_outlined),
      activeIcon: Icon(Icons.ac_unit),
      label: 'Metamask',
      initialLocation: '/metamask',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.access_alarms_outlined),
      activeIcon: Icon(Icons.access_alarm),
      label: 'Webview',
      initialLocation: '/webview',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.accessibility_new_outlined),
      activeIcon: Icon(Icons.accessibility_new),
      label: 'Webview Provider',
      initialLocation: '/webview_provider',
    ),
    MyCustomBottomNavBarItem(
      icon: Icon(Icons.explore_outlined),
      activeIcon: Icon(Icons.explore),
      label: 'BlueArchive',
      initialLocation: '/blueArchive',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    const labelStyle = TextStyle(fontFamily: 'Roboto');

    return Scaffold(
      body: SafeArea(child: widget.child),
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle,
        selectedItemColor: const Color(0xFF434343),
        selectedFontSize: 12,
        unselectedItemColor: const Color(0xFF838383),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          _goOtherTab(context, index);
        },
        currentIndex: _currentIndex,
        items: tabs,
      ),
    );
  }

  void _goOtherTab(BuildContext context, int index) {
    if (index == _currentIndex) return;
    GoRouter router = GoRouter.of(context);
    String location = tabs[index].initialLocation;

    setState(() {
      _currentIndex = index;
    });
    router.go(location);
  }
}

class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  final String initialLocation;

  const MyCustomBottomNavBarItem(
      {required this.initialLocation,
      required Widget icon,
      String? label,
      Widget? activeIcon})
      : super(icon: icon, label: label, activeIcon: activeIcon ?? icon);
}
