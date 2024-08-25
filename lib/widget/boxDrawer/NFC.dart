import 'package:flutter/material.dart';
import 'package:nfc_project/widget/NFC.dart';

class NFCBox extends StatefulWidget {
  final bool NFCBoxVisible;
  final double NFCBoxWidth;
  final double NFCBoxHeight;

  const NFCBox({
    Key? key,
    required this.NFCBoxVisible,
    required this.NFCBoxWidth,
    required this.NFCBoxHeight,
  }) : super(key: key);

  @override
  _NFCBoxState createState() => _NFCBoxState();
}

class _NFCBoxState extends State<NFCBox> {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const BorderRadius borderRadius = BorderRadius.only(
    topLeft: Radius.circular(36),
    topRight: Radius.circular(36),
  );
  static const double nfcBoxHeightFactor = 0.4;

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
      height: widget.NFCBoxHeight * nfcBoxHeightFactor,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(child: NFC()),
    );
  }
}
