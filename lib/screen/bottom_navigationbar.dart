import 'package:flutter/material.dart';
import 'package:kawi_app/screen/list_screen.dart';
import 'package:kawi_app/screen/profile_page.dart';

class BottomNavigationbar extends StatefulWidget {

  const BottomNavigationbar({super.key,});

  @override
  State<BottomNavigationbar> createState() => _BottomNavigationbarState();
}

class _BottomNavigationbarState extends State<BottomNavigationbar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [ProfilePage(), CommentPage()];
  void _onitemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onitemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person),label: 'profile'),
          BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'items'),
        ],
      ),
    );
  }
}
