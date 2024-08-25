import 'package:flutter/material.dart';

class NFC extends StatefulWidget {
  final bool isNFCDetected;

  const NFC({
    super.key,
    this.isNFCDetected = true,
  });

  @override
  _NFCState createState() => _NFCState();
}

class _NFCState extends State<NFC> {
  final Duration animationDuration = Duration(milliseconds: 600);
  late bool isNFCDetected;

  @override
  void initState() {
    super.initState();
    isNFCDetected = widget.isNFCDetected;
  }

  void toggleNFCStatus() {
    setState(() {
      isNFCDetected = !isNFCDetected;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double readIcon = 40;
    final Offset leftOffset = Offset(-readIcon - 6, 0);
    final Offset rightOffset = Offset(readIcon + 6, 0);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildNFCIcon(-90, rightOffset),
        GestureDetector(
          onTap: toggleNFCStatus,
          child: AnimatedContainer(
            duration: animationDuration,
            width: readIcon / 1.6,
            height: readIcon / 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isNFCDetected
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        buildNFCIcon(90, leftOffset),
      ],
    );
  }

  Widget buildNFCIcon(double angle, Offset offset) {
    return GestureDetector(
      onTap: toggleNFCStatus,
      child: Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: angle * 3.1415927 / 180,
          child: AnimatedContainer(
            duration: animationDuration,
            child: Icon(
              Icons.wifi_rounded,
              size: 120,
              color: isNFCDetected
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
