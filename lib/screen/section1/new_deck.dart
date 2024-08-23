import 'package:flutter/material.dart';
import 'package:nfc_project/screen/card_info.dart';
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
  int numberOfCards = 14;

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu1 = {
      list ? Icons.menu_rounded : Icons.window_rounded: _toggleList,
      numberOfCards > 0 ? Icons.upload_rounded : Icons.info_outline_rounded:
          null,
      widget.deckName: null,
      numberOfCards > 0 ? Icons.play_arrow_rounded : null: null,
      'Edit': _toggleMenu,
    };
    final Map<dynamic, dynamic> menu2 = {
      Icons.delete_rounded: null,
      null: null,
      widget.deckName: null,
      numberOfCards.toString(): null,
      'Save': _toggleMenu,
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
          return CustomCard(
            // imagePath: 'assets/card_image_$index.png', // ใช้หลังจากที่ทำ api เสร็จแล้ว
            imagePath: 'asset/image/Nightrose.png',
            initialCardCount: 1,
            isEdit: isEdit,
            page: CardInfoScreen(
              imagePath: 'asset/image/Nightrose.png',
              page: NewDeckScreen(
                deckName: widget.deckName,
              ),
              isAdd: false,
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }

  void _toggleMenu() {
    setState(() {
      menu = !menu;
      isEdit = !isEdit;
    });
  }

  void _toggleList() {
    setState(() {
      list = !list;
    });
  }
}
