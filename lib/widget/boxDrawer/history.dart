import 'package:flutter/material.dart';
import 'package:project/function/tag.dart';
import 'package:project/screen/section2/read.dart';
import 'package:project/screen/cardInfo.dart';
import 'package:project/widget/label/card.dart';
import 'package:project/api/service/model.dart';

class BoxHistory extends StatefulWidget {
  final bool BoxHistoryVisible;
  final double BoxHistoryHeight;

  const BoxHistory({
    Key? key,
    required this.BoxHistoryVisible,
    required this.BoxHistoryHeight,
  }) : super(key: key);

  @override
  _BoxHistoryState createState() => _BoxHistoryState();
}

class _BoxHistoryState extends State<BoxHistory> {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const double BoxHistoryWidth = 260;

  List<Model> savedCards = [];

  @override
  void initState() {
    super.initState();
    _loadSavedCards();
  }

  Future<void> _loadSavedCards() async {
    final cards = await TagService().load(game: 'cfv');
    setState(() {
      savedCards = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        widget.BoxHistoryVisible ? 0 : -BoxHistoryWidth,
        0,
        0,
      ),
      width: BoxHistoryWidth,
      height: widget.BoxHistoryHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        itemCount: savedCards.length,
        itemBuilder: (context, index) {
          final card = savedCards[index];
          return LabelCard(
            card: card,
            darkTheme: false,
            page: CardInfoScreen(card: card, page: ScreenRead()),
          );
        },
      ),
    );
  }
}
