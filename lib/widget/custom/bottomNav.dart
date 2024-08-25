import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/myDeck.dart';
import 'package:nfc_project/screen/section2/readWrite.dart';
import 'package:nfc_project/screen/section3/setting.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigation({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  final List<Widget> pages = [
    MyDeckScreen(),
    ReadWriteScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        navigationItem('My Deck', Icons.web_stories_rounded),
        navigationItem('Read', Icons.insert_page_break_outlined),
        navigationItem('Setting', Icons.settings_rounded),
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) => navigateToPage(index),
    );
  }

  BottomNavigationBarItem navigationItem(String label, IconData iconData) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: label);
  }

  void navigateToPage(int index) {
    if (index < pages.length) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => pages[index]),
      );
    }
  }
}
