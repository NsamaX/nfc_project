import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section2/read_write.dart';
import 'package:nfc_project/widget/introduction.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Introduction(
      title: 'Let\'s me know you.',
      showSigninIcon: true,
      buttom: 'Guess',
      page: const ReadWriteScreen(),
    );
  }
}
