import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/model.dart';

class LabelCard extends StatelessWidget {
  final bool darkTheme;
  final Model? card;
  final Widget? page;

  const LabelCard({
    Key? key,
    this.darkTheme = true,
    this.card,
    this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => page!),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 6),
        height: 60,
        decoration: BoxDecoration(
          color: darkTheme
              ? Theme.of(context).appBarTheme.backgroundColor
              : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              buildImage(),
              const SizedBox(width: 12),
              buildText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImage() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: card != null && card!.getImagePath().isNotEmpty
            ? DecorationImage(
                image: NetworkImage(card!.getImagePath()),
                fit: BoxFit.cover,
                onError: (_, __) => buildNoImage(),
              )
            : null,
      ),
      child:
          card == null || card!.getImagePath().isEmpty ? buildNoImage() : null,
    );
  }

  Widget buildNoImage() {
    return Icon(
      Icons.image_not_supported,
      size: 26,
      color: darkTheme ? null : Colors.black,
    );
  }

  Widget buildText(BuildContext context) {
    final textColor = darkTheme ? null : Colors.black;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            card?.getName() ?? 'Card Name',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Text(
            card?.getDescription() ?? 'Card Description',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: textColor),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
