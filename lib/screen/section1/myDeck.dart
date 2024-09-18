import 'package:flutter/material.dart';
import 'package:project/screen/section1/newDeck.dart';
import 'package:project/widget/card/deck.dart';
import 'package:project/widget/custom/appBar.dart';
import 'package:project/widget/custom/bottomNav.dart';
import 'package:project/function/deck.dart';
import 'package:project/api/service/model.dart';

class ScreenMyDeck extends StatefulWidget {
  const ScreenMyDeck({super.key});

  @override
  State<ScreenMyDeck> createState() => _ScreenMyDeckState();
}

class _ScreenMyDeckState extends State<ScreenMyDeck> {
  bool isEdit = false;
  List<Model> deckList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadDecks();
  }

  Future<void> loadDecks() async {
    setState(() {
      isLoading = true;
    });
    try {
      final deckService = DeckService(game: 'cfv');
      final decks = await deckService.load();
      setState(() {
        deckList = decks;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load decks: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  void navigateToNewDeck() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewDeckScreen(deckName: 'New Deck'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.open_in_new_rounded: navigateToNewDeck,
      'My Deck': null,
      Icons.edit_rounded: deckList.isNotEmpty ? toggleEdit : null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: deckList.length,
              itemBuilder: (context, index) {
                return Deck(
                  isEdit: isEdit,
                  deckName: deckList[index].getName(), // Display deck name
                );
              },
            ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }
}
