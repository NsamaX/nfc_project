import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:project/api/service/model.dart';

class CardInfo extends StatelessWidget {
  final bool isCustom;
  final Model? card;

  const CardInfo({
    super.key,
    this.isCustom = false,
    this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ListView(
        children: [
          if (isCustom) buildDottedBorder(context) else buildCardImage(context),
          const SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          buildDescription(context),
        ],
      ),
    );
  }

  Widget buildCardImage(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: card != null && card!.getImagePath().isNotEmpty
            ? Image.network(
                card!.getImagePath(),
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return buildErrorImage(context);
                },
              )
            : buildErrorImage(context),
      ),
    );
  }

  Widget buildErrorImage(BuildContext context) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_not_supported,
              size: 36,
            ),
            const SizedBox(height: 8),
            Text(
              'No Image Available',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDescription(BuildContext context) {
    if (isCustom) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.edit_rounded),
        ],
      );
    }

    if (card == null) {
      return Text(
        'No info',
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }

    if (card!.getMap().isEmpty) {
      return Opacity(
        opacity: 0.6,
        child: Text(
          card!.getDescription(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Opacity(
      opacity: 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: card!.getMap().entries.map<Widget>((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${entry.key}: ',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: '${entry.value}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              textAlign: TextAlign.start,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildDottedBorder(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: DottedBorder(
        color: Colors.white,
        borderType: BorderType.RRect,
        radius: const Radius.circular(16),
        dashPattern: const [16, 26],
        strokeWidth: 2,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.upload_rounded,
                size: 36,
              ),
              const SizedBox(height: 8),
              Text(
                'Upload Image',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
