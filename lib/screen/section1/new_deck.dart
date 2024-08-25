import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/track.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/custom/card.dart';

class NewDeckScreen extends StatefulWidget {
  final String deckName;

  const NewDeckScreen({super.key, required this.deckName});

  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  bool menu = true;
  bool list = false;
  bool isEdit = false;
  int numberOfCards = 10;

  void toggleMenu() {
    setState(() {
      menu = !menu;
      isEdit = !isEdit;
    });
  }

  void toggleList() {
    setState(() {
      list = !list;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu1 = {
      list ? Icons.menu_rounded : Icons.window_rounded: toggleList,
      numberOfCards > 0 ? Icons.upload_rounded : Icons.info_outline_rounded:
          null,
      widget.deckName: null,
      numberOfCards > 0 ? Icons.play_arrow_rounded : null:
          TrackScreen(deckName: widget.deckName),
      'Edit': toggleMenu,
    };
    final Map<dynamic, dynamic> menu2 = {
      Icons.delete_rounded: null,
      null: null,
      widget.deckName: null,
      numberOfCards.toString(): null,
      'Save': toggleMenu,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu ? menu1 : menu2),
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
          return CustomCard(isEdit: isEdit);
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }
}
