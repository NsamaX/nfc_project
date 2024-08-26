import 'package:flutter/material.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/screen/section2/readWrite.dart';
import 'package:nfc_project/screen/section2/search.dart';

class OptionBox extends StatefulWidget {
  final bool optionBoxVisible;

  const OptionBox({Key? key, required this.optionBoxVisible}) : super(key: key);

  @override
  _OptionBoxState createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox> {
  static final Duration animationDuration = Duration(milliseconds: 200);
  static final BorderRadius borderRadius = BorderRadius.circular(8);
  static const double boxSize = 50;
  static const double spacing = 16;

  final String game = 'cfv';
  late String imagePath;

  @override
  void initState() {
    super.initState();

    switch (game) {
      case 'cfv':
        imagePath = 'asset/image/icon_Vanguard.png';
        break;
      default:
        imagePath = 'asset/image/icon_flutter.png';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        widget.optionBoxVisible ? 0 : boxSize,
        0,
        0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildItem(
            image: imagePath,
            page: SearchScreen(game: game),
          ),
          buildItem(
            label: 'Other',
            page: SearchScreen(),
          ),
          buildItem(
            label: 'Custom',
            page: CardInfoScreen(
              page: ReadWriteScreen(),
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
