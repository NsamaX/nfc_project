import 'package:flutter/material.dart';
import 'package:nfc_project/screen/section2/search.dart';

class OpionBox extends StatefulWidget {
  final double boxSize = 50;
  final double spacing = 16;
  final bool optionBoxVisible;

  const OpionBox({Key? key, required this.optionBoxVisible}) : super(key: key);

  @override
  _OpionBoxState createState() => _OpionBoxState();
}

class _OpionBoxState extends State<OpionBox> {
  final BorderRadius borderRadius = BorderRadius.circular(8);
  final Duration animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: animationDuration,
      transform: Matrix4.translationValues(
        widget.optionBoxVisible ? 0 : widget.boxSize,
        0,
        0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildItem(
            image: 'asset/image/icon_Vanguard.png',
            page: SearchScreen(),
          ),
          _buildItem(
            label: 'Other',
            page: SearchScreen(),
          ),
          _buildItem(
            label: 'Add',
            page: null,
          ),
          _buildItem(
            label: 'Remove',
            page: null,
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    String? image,
    String? label,
    Widget? page,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.spacing),
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
          width: widget.boxSize,
          height: widget.boxSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: borderRadius,
          ),
          child: image != null
              ? ClipRRect(
                  borderRadius: borderRadius,
                  child: Image.asset(image, fit: BoxFit.cover),
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
