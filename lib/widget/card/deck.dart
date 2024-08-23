import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/new_deck.dart';

class Deck extends StatelessWidget {
  final String name;
  final bool isEdit;

  const Deck({
    super.key,
    required this.name,
    required this.isEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => NewDeckScreen(deckName: name)),
            );
          },
          child: Container(
            margin: EdgeInsets.all(6),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        if (isEdit)
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.remove_rounded),
              ),
            ),
          ),
      ],
    );
  }
}
