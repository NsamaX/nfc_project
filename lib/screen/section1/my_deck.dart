import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/new_deck.dart';
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
  int numberOfDecks = 4;

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
      Icons.edit_rounded: toggleEdit,
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
        itemCount: numberOfDecks,
        itemBuilder: (context, index) {
          return Deck(
            name: 'Deck ${index + 1}',
            isEdit: isEdit,
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 0),
    );
  }
}
