import 'package:flutter/material.dart';
import 'package:nfc_project/widget/boxDrawer/NFC.dart';
import 'package:nfc_project/widget/card/info.dart';
import 'package:nfc_project/widget/custom/appBar.dart';

class CardInfoScreen extends StatefulWidget {
  final String? imagePath;
  final String? detail;
  final Widget page;
  final bool isAdd;
  final bool isCustom;
  final bool isNFCDetected;

  const CardInfoScreen({
    super.key,
    this.imagePath,
    this.detail,
    required this.page,
    this.isAdd = true,
    this.isCustom = false,
    this.isNFCDetected = false,
  });

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  late bool isNFCDetected;

  @override
  void initState() {
    super.initState();
    isNFCDetected = widget.isNFCDetected;
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: widget.page,
      'Card Name': null,
      widget.isAdd
          ? !widget.isCustom
              ? 'Add'
              : 'Save'
          : null: !widget.isCustom ? _toggleAdd : null,
    };

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GestureDetector(
        onTap: isNFCDetected ? _toggleAdd : null,
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
              bottom: isNFCDetected ? 0 : -screenSize.height * 0.4,
              left: 0,
              right: 0,
              child: NFCBox(
                NFCBoxWidth: screenSize.width,
                NFCBoxHeight: screenSize.height,
                NFCBoxVisible: isNFCDetected,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleAdd() {
    setState(() {
      isNFCDetected = !isNFCDetected;
    });
  }
}
