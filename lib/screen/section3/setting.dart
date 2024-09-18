import 'package:flutter/material.dart';
import 'package:project/screen/signin.dart';
import 'package:project/screen/section3/tracked_cards.dart';
import 'package:project/widget/custom/appBar.dart';
import 'package:project/widget/custom/bottomNav.dart';
import 'package:project/widget/label/normal.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            'page': TrackedScreen(),
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
            'page': ScreenWelcome(),
          },
        ]
      },
      {
        'title': 'Support',
        'content': [
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

    final Map<dynamic, dynamic> menu = {
      'Setting': null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Center(child: LabelNormal(label: setting)),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
