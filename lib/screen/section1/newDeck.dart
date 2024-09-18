import 'package:flutter/material.dart';
import 'package:project/function/deck.dart';
import 'package:project/api/service/model.dart';
import 'package:project/function/tag.dart';
import 'package:project/screen/section1/tracking.dart';
import 'package:project/screen/cardInfo.dart';
import 'package:project/widget/custom/appBar.dart';
import 'package:project/widget/custom/bottomNav.dart';
import 'package:project/widget/custom/card.dart';

class NewDeckScreen extends StatefulWidget {
  final String deckName;

  const NewDeckScreen({super.key, required this.deckName});

  @override
  _NewDeckScreenState createState() => _NewDeckScreenState();
}

class _NewDeckScreenState extends State<NewDeckScreen> {
  final bool TestSystem = true;

  bool menu = true;
  bool list = false;
  bool isEdit = false;
  List<Model> deck = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDeck();
  }

  Future<void> loadTrackedCards() async {
    final cards = await TagService().load(game: 'cfv');
    setState(() {
      deck = cards;
    });
  }

  Future<void> loadDeck() async {
    setState(() {
      isLoading = true;
    });
    try {
      final cards = await DeckService(game: 'cfv').load();
      setState(() {
        deck = cards;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load deck: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void saveDeck() {
    DeckService(game: 'cfv').saveDeck(deck).then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deck saved successfully')),
        );
      },
    ).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save deck: $e')),
      );
    });
    toggleMenu();
  }

  void delete() {
    if (deck.isEmpty) return;
    DeckService(game: 'cfv').delete().then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleted deck successfully')),
        );
        setState(() {
          deck = [];
        });
      },
    ).catchError((e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete deck: $e')),
      );
    });
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
      TestSystem ? Icons.refresh : null: loadTrackedCards, // เพื่อการทดสอบแอป
      widget.deckName: null,
      deck.length.toString(): null,
      'Save': saveDeck,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu ? menu1 : menu2),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
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
