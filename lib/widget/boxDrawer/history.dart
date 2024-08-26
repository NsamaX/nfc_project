import 'package:flutter/material.dart';
import 'package:nfc_project/function/tag.dart';
import 'package:nfc_project/screen/section2/readWrite.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/label/card.dart';
import 'package:nfc_project/api/service/model.dart';

class HistoryBox extends StatefulWidget {
  final bool historyBoxVisible;
  final double historyBoxHeight;

  const HistoryBox({
    Key? key,
    required this.historyBoxVisible,
    required this.historyBoxHeight,
  }) : super(key: key);

  @override
  _HistoryBoxState createState() => _HistoryBoxState();
}

class _HistoryBoxState extends State<HistoryBox> {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const double historyBoxWidth = 260;

  List<Model> savedCards = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCards();
  }

  Future<void> _loadSavedCards() async {
    final cards = await TagService().load(game: 'cfv');
    setState(() {
      savedCards = cards;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        widget.historyBoxVisible ? 0 : -historyBoxWidth,
        0,
        0,
      ),
      width: historyBoxWidth,
      height: widget.historyBoxHeight,
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
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: savedCards.length,
              itemBuilder: (context, index) {
                final card = savedCards[index];
                return LabelCard(
                  card: card,
                  darkTheme: false,
                  page: CardInfoScreen(card: card, page: ReadWriteScreen()),
                );
              },
            ),
    );
  }
}
