import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/model.dart';

class CustomCard extends StatefulWidget {
  final bool isEdit;
  final Model? card;
  final Widget? page;

  const CustomCard({
    Key? key,
    this.isEdit = true,
    this.card,
    this.page,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  int cardCount = 0;

  void incrementCardCount() {
    setState(() {
      cardCount++;
    });
  }

  void decrementCardCount() {
    if (cardCount > 0) {
      setState(() {
        cardCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.page != null) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => widget.page!),
              );
            }
          },
          child: AspectRatio(
            aspectRatio: 3 / 4,
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: widget.card != null &&
                        widget.card!.getImagePath().isNotEmpty
                    ? Image.network(
                        widget.card!.getImagePath(),
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        child: const Icon(
                          Icons.image_not_supported,
                          size: 36,
                        ),
                      ),
              ),
            ),
          ),
        ),
        if (widget.isEdit)
          Positioned(
            top: 0,
            right: 0,
            child: Column(
              children: [
                buildCardCountDisplay(context),
                buildCircleButton(
                  icon: Icons.add,
                  onPressed: incrementCardCount,
                ),
                buildCircleButton(
                  icon: Icons.remove,
                  onPressed: decrementCardCount,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildCardCountDisplay(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$cardCount',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 16,
          ),
        ),
      ),
    );
  }
}
