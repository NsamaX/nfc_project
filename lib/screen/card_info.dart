import 'package:flutter/material.dart';
import 'package:nfc_project/widget/boxDrawer/NFC.dart';
import 'package:nfc_project/widget/card/info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';

// ignore: must_be_immutable
class CardInfoScreen extends StatefulWidget {
  final String? imagePath;
  final String? detail;
  final Widget page;
  final bool isAdd;
  final bool isCustom;
  bool isNFCDetected;

  CardInfoScreen({
    super.key,
    this.imagePath,
    this.detail,
    required this.page,
    this.isAdd = false,
    this.isCustom = false,
    this.isNFCDetected = false,
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

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GestureDetector(
        onTap: widget.isNFCDetected ? _toggleAdd : null,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            CardInfo(
              imagePath: widget.imagePath,
              detail: widget.detail,
              isCustom: widget.isCustom,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              bottom: widget.isNFCDetected ? 0 : -screenSize.height * 0.4,
              left: 0,
              right: 0,
              child: NFCBox(
                NFCBoxWidth: screenSize.width,
                NFCBoxHeight: screenSize.height,
                NFCBoxVisible: widget.isNFCDetected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleAdd() {
    setState(() {
      widget.isNFCDetected = !widget.isNFCDetected;
    });
  }
}
