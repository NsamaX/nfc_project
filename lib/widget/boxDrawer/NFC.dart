import 'package:flutter/material.dart';
import 'package:project/api/service/model.dart';
import 'package:project/widget/NFC.dart';

class BoxNFC extends StatefulWidget {
  final bool BoxNFCVisible;
  final double BoxNFCWidth;
  final double BoxNFCHeight;
  final Model? card;

  const BoxNFC({
    Key? key,
    required this.BoxNFCVisible,
    required this.BoxNFCWidth,
    required this.BoxNFCHeight,
    this.card,
  }) : super(key: key);

  @override
  _BoxNFCState createState() => _BoxNFCState();
}

class _BoxNFCState extends State<BoxNFC> {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const BorderRadius borderRadius = BorderRadius.only(
    topLeft: Radius.circular(36),
    topRight: Radius.circular(36),
  );
  static const double BoxnfcHeightFactor = 0.4;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        0,
        widget.BoxNFCVisible ? 0 : widget.BoxNFCHeight,
        0,
      ),
      width: widget.BoxNFCWidth,
      height: widget.BoxNFCHeight * BoxnfcHeightFactor,
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
      child: Center(child: NFC(card: widget.card)),
    );
  }
}
