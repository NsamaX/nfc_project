import 'package:flutter/material.dart';
import 'package:project/api/service/model.dart';
import 'package:project/widget/boxDrawer/NFC.dart';
import 'package:project/widget/card/info.dart';
import 'package:project/widget/custom/appBar.dart';

class CardInfoScreen extends StatefulWidget {
  final Model? card;
  final Widget page;
  final bool isAdd;
  final bool isCustom;
  final bool isNFCDetected;

  const CardInfoScreen({
    super.key,
    this.card,
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

  void toggleNFCDetection() {
    setState(() {
      isNFCDetected = !isNFCDetected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: widget.page,
      'Card Name': null,
      widget.isAdd ? (widget.isCustom ? 'Save' : 'Add') : null:
          (widget.isCustom ? null : toggleNFCDetection),
    };

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GestureDetector(
        onTap: isNFCDetected ? toggleNFCDetection : null,
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            CardInfo(
              isCustom: widget.isCustom,
              card: widget.card,
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              bottom: isNFCDetected ? 0 : -screenSize.height * 0.4,
              left: 0,
              right: 0,
              child: BoxNFC(
                BoxNFCVisible: isNFCDetected,
                BoxNFCWidth: screenSize.width,
                BoxNFCHeight: screenSize.height,
                card: widget.card,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
