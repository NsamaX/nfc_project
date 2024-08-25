import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/newDeck.dart';
import 'package:nfc_project/widget/card/deck.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';

class MyDeckScreen extends StatefulWidget {
  const MyDeckScreen({super.key});

  @override
  State<MyDeckScreen> createState() => _MyDeckScreenState();
}

class _MyDeckScreenState extends State<MyDeckScreen> {
  bool isEdit = false;
  final int deck = 0;

  void toggleEdit() {
    setState(() {
      isEdit = !isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.open_in_new_rounded: NewDeckScreen(deckName: 'New Deck'),
      'My Deck': null,
      Icons.edit_rounded: deck > 0 ? toggleEdit : null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: deck,
        itemBuilder: (context, index) {
          return Deck(
            isEdit: isEdit,
            deckName: 'Deck ${index + 1}',
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }
}
