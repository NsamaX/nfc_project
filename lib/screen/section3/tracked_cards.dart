import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/deck.dart';
import 'package:nfc_project/api/service/model.dart';
import 'package:nfc_project/screen/section3/setting.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/custom/card.dart';

class TrackedScreen extends StatefulWidget {
  const TrackedScreen({super.key});

  @override
  State<TrackedScreen> createState() => _TrackedScreenState();
}

class _TrackedScreenState extends State<TrackedScreen> {
  List<Model> trackedCards = [];

  @override
  void initState() {
    super.initState();
    loadTrackedCards();
  }

  Future<void> loadTrackedCards() async {
    final cards = await DeckService().load(game: 'cfv');
    setState(() {
      trackedCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        itemCount: trackedCards.length,
        itemBuilder: (context, index) {
          return CustomCard(
            card: trackedCards[index],
            page: CardInfoScreen(
              card: trackedCards[index],
              page: TrackedScreen(),
              isAdd: false,
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
