import 'package:flutter/material.dart';
import 'package:nfc_project/widget/custom/appBar.dart';

class AddCardScreen extends StatelessWidget {
  final Widget page;

  const AddCardScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: page,
      'Custom Card': null,
      'Save': null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      // body: CardInfo(),
    );
  }
}
