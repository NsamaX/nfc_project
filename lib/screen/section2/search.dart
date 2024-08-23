import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section2/read_write.dart';
import 'package:nfc_project/screen/card_info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/searchBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class SearchScreen extends StatelessWidget {
  final bool other;

  const SearchScreen({super.key, this.other = false});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> card_log = !other
        ? List.generate(30, (index) {
            final String imagePath = 'asset/image/icon_flutter.png';
            return {
              'name': 'Card name ${index + 1}',
              'content': [
                {
                  'image': imagePath,
                  'detail': 'Description',
                  'page': CardInfoScreen(
                    imagePath: imagePath,
                    page: SearchScreen(),
                    isAdd: true,
                  ),
                },
              ]
            };
          })
        : [
            {
              'name': 'My Collection',
              'content': [
                {
                  'image': 'asset/image/icon_flutter.png',
                  'detail': 'Description',
                  'page': null,
                },
              ],
            },
            {
              'name': 'Other',
              'content': [
                {
                  'image': 'asset/image/icon_flutter.png',
                  'detail': 'Description',
                  'page': null,
                }
              ],
            },
          ];

    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: ReadWriteScreen(),
      !other ? 'Search' : 'Other': null,
      null: null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Column(
        children: [
          CustomSearchBar(),
          SizedBox(height: 6),
          LabelCard(
            label: card_log,
            whiteBackgrund: false,
          ),
        ],
      ),
    );
  }
}
