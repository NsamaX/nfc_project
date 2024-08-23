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

  void _incrementCardCount() {
    setState(() {
      cardCount++;
    });
  }

  void _decrementCardCount() {
    setState(() {
      if (cardCount > 0) {
        cardCount--;
      }
    });
  }

  void _setZeroCardCount() {
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
                  padding: EdgeInsets.all(4),
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
                _buildCircleButton(
                  icon: Icons.add,
                  onPressed: _incrementCardCount,
                  context: context,
                ),
                _buildCircleButton(
                  icon: Icons.remove,
                  onPressed: _decrementCardCount,
                  context: context,
                ),
                _buildCircleButton(
                  icon: Icons.delete,
                  onPressed: _setZeroCardCount,
                  context: context,
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildCircleButton({
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.only(top: 4),
        padding: EdgeInsets.all(4),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
