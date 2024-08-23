import 'package:flutter/material.dart';

class CardInfo extends StatelessWidget {
  final String imagePath;

  const CardInfo({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
      child: ListView(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: AspectRatio(
              aspectRatio: 3 / 4,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.edit_rounded),
              Text(
                '...',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
