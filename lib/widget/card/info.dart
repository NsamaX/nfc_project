import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class CardInfo extends StatelessWidget {
  final String? imagePath;
  final String? detail;
  final bool isCustom;

  const CardInfo({
    super.key,
    this.imagePath,
    this.detail,
    this.isCustom = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
      child: ListView(
        children: [
          if (isCustom || imagePath == null || imagePath!.isEmpty)
            DashedBorderContainer(),
          if (!isCustom && imagePath != null && imagePath!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Image.asset(
                  imagePath!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          SizedBox(height: 16),
          Text(
            'Description',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: 8),
          Row(
            children: [
              if (isCustom)
                Icon(Icons.edit_rounded)
              else
                Opacity(
                  opacity: 0.6,
                  child: Text(
                    detail?.isEmpty ?? true ? 'No description' : detail!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashedBorderContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: DottedBorder(
        color: Theme.of(context).primaryColorLight,
        borderType: BorderType.RRect,
        radius: Radius.circular(16),
        dashPattern: [16, 26],
        strokeWidth: 2,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.upload_rounded,
                  size: 36,
                ),
                SizedBox(height: 8),
                Text(
                  "Upload Image",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
