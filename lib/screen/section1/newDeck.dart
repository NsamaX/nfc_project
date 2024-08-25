import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/deck.dart';
import 'package:nfc_project/api/service/model.dart';
import 'package:nfc_project/screen/section1/tracking.dart';
import 'package:nfc_project/screen/cardInfo.dart';
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
  List<Model> deck = [];

  @override
  void initState() {
    super.initState();
    loadDeck();
  }

  Future<void> loadDeck() async {
    final cards = await DeckService().load(game: 'cfv');
    setState(() {
      deck = cards;
    });
  }

  void delete() {
    if (deck.isEmpty) return;
    DeckService().delete().then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleted deck successfully')),
        );
        setState(() {
          deck = [];
        });
      },
    );
  }

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
      deck.length > 0 ? Icons.upload_rounded : Icons.info_outline_rounded: null,
      widget.deckName: null,
      deck.length > 0 ? Icons.play_arrow_rounded : null:
          TrackingScreen(deckName: widget.deckName),
      'Edit': toggleMenu,
    };
    final Map<dynamic, dynamic> menu2 = {
      Icons.delete_rounded: delete,
      null: null,
      widget.deckName: null,
      deck.length.toString(): null,
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
        itemCount: deck.length,
        itemBuilder: (context, index) {
          return CustomCard(
            isEdit: isEdit,
            card: deck[index],
            page: CardInfoScreen(
              card: deck[index],
              page: NewDeckScreen(deckName: widget.deckName),
              isAdd: false,
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }
}
