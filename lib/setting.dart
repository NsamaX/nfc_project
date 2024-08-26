import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section0/introduction.dart';
import 'package:nfc_project/screen/section3/tracked_cards.dart';

class AppStrings {
  // Notification Messages
  static const String addTag = 'Card has been added to the tag.';
  static const String copyToClipboard =
      'Deck log has been copied to the clipboard.';
  static const String warningMessage =
      'You can scan cards while playing on this page. Cards are counted as removed from the deck if scanned. and will be added to the deck if a previously scanned card is scanned. Click OK if you\'ve read it.';

  // Settings
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
          'page': IntroductionScreen(),
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
}
