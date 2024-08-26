import 'package:flutter/material.dart';
import 'package:nfc_project/setting.dart';
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
      body: Center(child: LabelNormal(label: AppStrings().setting)),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
