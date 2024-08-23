import 'package:flutter/material.dart';
import 'package:nfc_project/widget/NFC.dart';

class NFCBox extends StatefulWidget {
  final double NFCBoxWidth;
  final double NFCBoxHeight;
  final bool NFCBoxVisible;

  const NFCBox({
    Key? key,
    required this.NFCBoxWidth,
    required this.NFCBoxHeight,
    required this.NFCBoxVisible,
  }) : super(key: key);

  @override
  _NFCBoxState createState() => _NFCBoxState();
}

class _NFCBoxState extends State<NFCBox> {
  final Duration animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        0,
        widget.NFCBoxVisible ? 0 : widget.NFCBoxHeight,
        0,
      ),
      width: widget.NFCBoxWidth,
      height: widget.NFCBoxHeight * 0.4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Center(
        child: NFC(isNFCDetected: true),
      ),
    );
  }
}
