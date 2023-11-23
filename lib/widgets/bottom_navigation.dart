import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavigation extends StatefulWidget {
  final void Function(int) setPage;

  const BottomNavigation({super.key, required this.setPage});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 5.0),
        child: GNav(
          backgroundColor: Colors.white,
          gap: 8,
          color: Colors.grey.shade700,
          activeColor: Colors.purple,
          iconSize: 24,
          tabBackgroundColor: Colors.purple.withOpacity(0.1),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          duration: const Duration(milliseconds: 1000),
          tabs: const [
            GButton(icon: Icons.home, text: 'Home'),
            GButton(icon: Icons.history, text: 'History'),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
            widget.setPage(index);
          },
        ),
      ),
    );
  }
}
