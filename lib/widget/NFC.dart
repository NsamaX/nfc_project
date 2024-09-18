import 'package:flutter/material.dart';
import 'package:project/api/service/model.dart';
import 'package:project/function/tag.dart';

class NFC extends StatefulWidget {
  final bool NFCDetected;
  final Model? card;

  const NFC({
    super.key,
    this.NFCDetected = true,
    this.card,
  });

  @override
  _NFCState createState() => _NFCState();
}

class _NFCState extends State<NFC> {
  final Duration animationDuration = const Duration(milliseconds: 600);
  late bool NFCDetected;

  @override
  void initState() {
    super.initState();
    NFCDetected = widget.NFCDetected;
  }

  void toggleNFCStatus() {
    setState(() {
      NFCDetected = !NFCDetected;
    });
  }

  Future<void> toggleAdd() async {
    if (widget.card != null) {
      await TagService().save(
        game: 'cfv',
        card: widget.card!,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Card has been added to the tag.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
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
          onTap: toggleAdd,
          child: AnimatedContainer(
            duration: animationDuration,
            width: readIcon / 1.6,
            height: readIcon / 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: NFCDetected
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
      onTap: toggleAdd,
      child: Transform.translate(
        offset: offset,
        child: Transform.rotate(
          angle: angle * 3.1415927 / 180,
          child: AnimatedContainer(
            duration: animationDuration,
            child: Icon(
              Icons.wifi_rounded,
              size: 120,
              color: NFCDetected
                  ? Theme.of(context).secondaryHeaderColor
                  : Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
      ),
    );
  }
}
