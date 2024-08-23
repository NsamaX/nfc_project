import 'package:flutter/material.dart';
import 'package:nfc_project/widget/card/info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';

// ignore: must_be_immutable
class CardInfoScreen extends StatefulWidget {
  final String imagePath;
  final Widget page;
  bool isAdd;

  CardInfoScreen({
    super.key,
    required this.imagePath,
    required this.page,
    required this.isAdd,
  });

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: widget.page,
      'Card Name': null,
      widget.isAdd ? 'Add' : null: _toggleAdd,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: CardInfo(imagePath: widget.imagePath),
    );
  }

  void _toggleAdd() {
    setState(() {
      widget.isAdd = !widget.isAdd;
    });
  }
}
