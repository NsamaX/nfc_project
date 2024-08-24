import 'package:flutter/material.dart';

class CustomCard extends StatefulWidget {
  final String imagePath;
  final int initialCardCount;
  final bool isEdit;
  final Widget page;

  const CustomCard({
    Key? key,
    required this.imagePath,
    required this.initialCardCount,
    required this.isEdit,
    required this.page,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  late int cardCount;

  @override
  void initState() {
    super.initState();
    cardCount = widget.initialCardCount;
  }

  void incrementCardCount() {
    setState(() {
      cardCount++;
    });
  }

  void decrementCardCount() {
    setState(() {
      if (cardCount > 0) {
        cardCount--;
      }
    });
  }

  // ignore: unused_element
  void setZeroCardCount() {
    setState(() {
      cardCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => widget.page),
            );
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
                child: Image.asset(
                  widget.imagePath,
                  fit: BoxFit.cover,
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
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$cardCount',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                buildCircleButton(
                  icon: Icons.add,
                  onPressed: incrementCardCount,
                  context: context,
                ),
                buildCircleButton(
                  icon: Icons.remove,
                  onPressed: decrementCardCount,
                  context: context,
                ),
                // buildCircleButton(
                //   icon: Icons.delete,
                //   onPressed: setZeroCardCount,
                //   context: context,
                // ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon),
        ),
      ),
    );
  }
}
