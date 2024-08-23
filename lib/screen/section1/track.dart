import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/new_deck.dart';
import 'package:nfc_project/screen/card_info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class TrackScreen extends StatelessWidget {
  final String deckName;
  final int numberOfCards = 30;

  const TrackScreen({super.key, required this.deckName});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> card_log = List.generate(30, (index) {
      final String imagePath = 'asset/image/icon_flutter.png';
      return {
        'name': 'Card name ${index + 1}',
        'content': [
          {
            'image': imagePath,
            'detail': 'Description',
            'page': CardInfoScreen(
              imagePath: imagePath,
              page: TrackScreen(deckName: deckName),
            ),
          },
        ],
        'numberOfCard': 0,
      };
    });

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
        child: LabelCard(
          label: card_log,
          whiteBackgrund: false,
          play: true,
        ),
      ),
    );
  }
}
