import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  final void Function(int) setPage;

  const BottomNavigation({super.key, required this.setPage});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      widget.setPage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: 70,
      onDestinationSelected: (int index) => _onItemTapped(index),
      selectedIndex: _currentIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home_filled),
          label: "Home",
        ),
        NavigationDestination(
          icon: Icon(Icons.history),
          label: "History",
        ),
      ],
    );
  }
}
