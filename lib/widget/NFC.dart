import 'package:flutter/material.dart';

class NFC extends StatefulWidget {
  final bool isNFCDetected;

  const NFC({super.key, required this.isNFCDetected});

  @override
  _NFCState createState() => _NFCState();
}

class _NFCState extends State<NFC> {
  late bool isNFCDetected;
  final Duration animationDuration = Duration(milliseconds: 600);

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

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: toggleNFCStatus,
          child: Transform.translate(
            offset: Offset(readIcon + 6, 0),
            child: Transform.rotate(
              angle: -90 * 3.1415927 / 180,
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
        ),
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
        GestureDetector(
          onTap: toggleNFCStatus,
          child: Transform.translate(
            offset: Offset(-readIcon - 6, 0),
            child: Transform.rotate(
              angle: 90 * 3.1415927 / 180,
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
        ),
      ],
    );
  }
}
