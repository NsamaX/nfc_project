import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section3/setting.dart';
import 'package:nfc_project/screen/card_info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/custom/card.dart';

class TrackedScreen extends StatelessWidget {
  const TrackedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int numberOfCards = 10;

    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: SettingScreen(),
      'Tracked': null,
      null: null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: numberOfCards,
        itemBuilder: (context, index) {
          return CustomCard(
            page: CardInfoScreen(page: TrackedScreen()),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
