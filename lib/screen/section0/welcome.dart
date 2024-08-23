import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section0/signin.dart';
import 'package:nfc_project/widget/introduction.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Introduction(
      title: 'NFC Deck Tracker',
      detail: 'NFC Deck Tracker simplifies card management. '
          'Read, track, and organize your cards with ease, '
          'ensuring you always know what’s in your deck and '
          'enhancing your game play.',
      buttom: 'Start',
      page: const SignInScreen(),
    );
  }
}
