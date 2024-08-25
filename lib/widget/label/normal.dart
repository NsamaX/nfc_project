import 'package:flutter/material.dart';

class LabelNormal extends StatefulWidget {
  final List<Map<String, dynamic>> label;

  const LabelNormal({Key? key, required this.label}) : super(key: key);

  @override
  State<LabelNormal> createState() => _LabelNormalState();
}

class _LabelNormalState extends State<LabelNormal> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...widget.label.map<Widget>((category) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (category['title'] != null)
                buildTitle(text: category['title'] as String),
              ...category['content'].map<Widget>((item) {
                return buildContent(
                  icon: item['icon'],
                  text: item['text'] as String,
                  page: item['page'] as Widget?,
                );
              }).toList(),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget buildTitle({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 16, bottom: 8),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
      ),
    );
  }

  Widget buildContent({
    required dynamic icon,
    required String text,
    Widget? page,
  }) {
    return GestureDetector(
      onTap: () {
        if (page != null) {
          if (text == 'Sign out') {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => page),
              (route) => false,
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        }
      },
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).appBarTheme.backgroundColor,
          border: Border(
            bottom: BorderSide(
              color: Colors.white.withOpacity(0.6),
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 12),
              Text(text, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
