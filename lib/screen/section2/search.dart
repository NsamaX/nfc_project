import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section2/read.dart';
import 'package:nfc_project/screen/card_info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/searchBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: ReadScreen(),
      'Search': null,
      null: null,
    };

    return Scaffold(
      appBar: CustomAppBar(
        menu: menu,
      ),
      body: Column(
        children: [
          CustomSearchBar(),
          LabelCard(
            label: card_log,
            whiteBackgrund: false,
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> card_log = List.generate(30, (index) {
  final String imagePath = 'asset/image/Nightrose.png';
  return {
    'name': 'Arisa Mihairovuna Kujō ${index + 1}',
    'content': [
      {
        'image': imagePath,
        'detail': 'Detail ${index + 1}',
        'page': CardInfoScreen(
          imagePath: imagePath,
          page: SearchScreen(),
          isAdd: true,
        ),
      },
    ]
  };
});
