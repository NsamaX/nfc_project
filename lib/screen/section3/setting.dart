import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section0/welcome.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/label/normal.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      'Setting': null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Center(
        child: LabelNormal(label: setting),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}

final List<Map<String, dynamic>> setting = [
  {
    'title': 'Account',
    'content': [
      {
        'icon': Icons.account_circle,
        'text': 'Account',
        'page': null,
      },
      {
        'icon': Icons.book_rounded,
        'text': 'Tracked cards',
        'page': null,
      },
    ]
  },
  {
    'title': 'General',
    'content': [
      {
        'icon': Icons.language_rounded,
        'text': 'Language',
        'page': null,
      },
      {
        'icon': Icons.auto_stories_rounded,
        'text': 'About',
        'page': null,
      },
      {
        'icon': Icons.privacy_tip_rounded,
        'text': 'Privacy',
        'page': null,
      },
      {
        'icon': Icons.logout_rounded,
        'text': 'Sign out',
        'page': WelcomeScreen(),
      },
    ]
  },
  {
    'title': 'Support',
    'content': [
      // {
      //   'icon': Icons.mail_rounded,
      //   'text': 'Contact',
      //   'page': null,
      // },
      {
        'icon': Icons.coffee_rounded,
        'text': 'Donate',
        'page': null,
      },
      {
        'icon': Icons.api_rounded,
        'text': 'API : https://card-fight-vanguard-api.ue.r.appspot.com',
        'page': null,
      },
    ]
  },
];
