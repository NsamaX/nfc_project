import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/my_deck.dart';
import 'package:nfc_project/screen/section2/read_write.dart';
import 'package:nfc_project/screen/section3/setting.dart';

class CustomBottomNavigation extends StatefulWidget {
  final int currentIndex;

  const CustomBottomNavigation({Key? key, required this.currentIndex})
      : super(key: key);

  @override
  State<CustomBottomNavigation> createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        navigation('My Deck', Icons.web_stories_rounded),
        navigation('Read', Icons.insert_page_break_outlined),
        navigation('Setting', Icons.settings_rounded)
      ],
      currentIndex: widget.currentIndex,
      onTap: (index) => navigate(context: context, index: index),
    );
  }

  BottomNavigationBarItem navigation(String label, IconData iconData) {
    return BottomNavigationBarItem(icon: Icon(iconData), label: label);
  }

  void navigate({required BuildContext context, required int index}) {
    Widget page;

    switch (index) {
      case 0:
        page = MyDeckScreen();
        break;
      case 1:
        page = ReadWriteScreen();
        break;
      case 2:
        page = SettingScreen();
        break;
      default:
        page = Container();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
