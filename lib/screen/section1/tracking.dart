import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/newDeck.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class TrackingScreen extends StatelessWidget {
  final String deckName;
  final int numberOfCards = 1;

  const TrackingScreen({super.key, required this.deckName});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: NewDeckScreen(deckName: deckName),
      null: null,
      'Track': null,
      numberOfCards.toString(): null,
      Icons.refresh_rounded: null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: ListView.builder(
          itemCount: numberOfCards,
          itemBuilder: (context, index) => LabelCard(
            page: CardInfoScreen(
              page: TrackingScreen(deckName: deckName),
              isAdd: false,
            ),
          ),
        ),
      ),
    );
  }
}
