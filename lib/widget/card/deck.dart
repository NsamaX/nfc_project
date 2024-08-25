import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section1/newDeck.dart';

class Deck extends StatelessWidget {
  final bool isEdit;
  final String deckName;

  const Deck({
    super.key,
    required this.isEdit,
    required this.deckName,
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
                builder: (context) => NewDeckScreen(deckName: deckName),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(6),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                deckName,
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
                child: const Icon(Icons.remove_rounded),
              ),
            ),
          ),
      ],
    );
  }
}
