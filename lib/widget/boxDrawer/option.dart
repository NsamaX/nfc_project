import 'package:flutter/material.dart';
import 'package:project/screen/cardInfo.dart';
import 'package:project/screen/section2/read.dart';
import 'package:project/screen/section2/search.dart';

class BoxOption extends StatefulWidget {
  final bool BoxOptionVisible;

  const BoxOption({Key? key, required this.BoxOptionVisible}) : super(key: key);

  @override
  _BoxOptionState createState() => _BoxOptionState();
}

class _BoxOptionState extends State<BoxOption> {
  static final Duration animationDuration = Duration(milliseconds: 200);
  static final BorderRadius borderRadius = BorderRadius.circular(8);
  static const double boxSize = 50;
  static const double spacing = 16;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        widget.BoxOptionVisible ? 0 : boxSize,
        0,
        0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(
            image: 'asset/image/icon_Vanguard.png',
            page: ScreenSearch(game: 'cfv'),
          ),
          buildItem(
            label: 'Other',
            page: ScreenSearch(),
          ),
          buildItem(
            label: 'Custom',
            page: CardInfoScreen(
              page: ScreenRead(),
              isCustom: true,
            ),
          ),
          buildItem(
            label: 'Remove',
            page: null,
          ),
        ],
      ),
    );
  }

  Widget buildItem({
    String? image,
    String? label,
    Widget? page,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: spacing),
      child: GestureDetector(
        onTap: () {
          if (page != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        child: Container(
          width: boxSize,
          height: boxSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: image != null
              ? Padding(
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: borderRadius,
                    child: Image.asset(image, fit: BoxFit.cover),
                  ),
                )
              : Center(
                  child: Text(
                    label ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black),
                  ),
                ),
        ),
      ),
    );
  }
}
