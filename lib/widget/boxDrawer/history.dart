import 'package:flutter/material.dart';
import 'package:nfc_project/widget/label/card.dart';

class HistoryBox extends StatefulWidget {
  final List<Map<String, dynamic>> historyLog;
  final double historyBoxHeight;
  final bool historyBoxVisible;

  const HistoryBox({
    Key? key,
    required this.historyLog,
    required this.historyBoxHeight,
    required this.historyBoxVisible,
  }) : super(key: key);

  @override
  _HistoryBoxState createState() => _HistoryBoxState();
}

class _HistoryBoxState extends State<HistoryBox> {
  final double historyBoxWidth = 260;
  final Duration animationDuration = const Duration(milliseconds: 200);

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
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
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
      child: LabelCard(label: widget.historyLog),
    );
  }
}
