import 'package:flutter/material.dart';

class LabelCard extends StatelessWidget {
  final List<Map<String, dynamic>> label;
  final bool whiteBackgrund;

  const LabelCard({
    Key? key,
    required this.label,
    this.whiteBackgrund = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int index = 0;

    return Expanded(
      child: ListView.builder(
        itemCount: label.length,
        itemBuilder: (context, categoryIndex) {
          final category = label[categoryIndex];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: category['content'].map<Widget>((item) {
              index++;
              return GestureDetector(
                onTap: () {
                  if (item['page'] != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => item['page']),
                    );
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteBackgrund
                        ? Colors.white
                        : Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: whiteBackgrund
                        ? BorderRadius.only(
                            topRight:
                                index == 1 ? Radius.circular(16) : Radius.zero,
                            bottomLeft: Radius.circular(16),
                            bottomRight: Radius.circular(16),
                          )
                        : BorderRadius.zero,
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
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: item['image'].isNotEmpty
                              ? Image.asset(
                                  item['image'],
                                  width: 40,
                                  height: 40,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 40,
                                  height: 40,
                                  color: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  child: Icon(
                                    Icons.image_not_supported,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                category['name'],
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: whiteBackgrund
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              Text(
                                item['detail']?.isNotEmpty ?? false
                                    ? item['detail']
                                    : 'None',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: whiteBackgrund
                                          ? Colors.black.withOpacity(0.6)
                                          : Colors.white.withOpacity(0.6),
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
