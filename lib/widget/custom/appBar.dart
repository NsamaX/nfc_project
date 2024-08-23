import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Map<dynamic, dynamic> menu;

  const CustomAppBar({Key? key, required this.menu}) : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: widget.menu.length == 1
          ? Center(
              child: _buildMenuItem(
                  widget.menu.keys.first, widget.menu.values.first),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widget.menu.entries
                  .map((entry) => _buildMenuItem(entry.key, entry.value))
                  .toList(),
            ),
    );
  }

  Widget _buildMenuItem(dynamic menu, dynamic onTapFunction) {
    final theme = Theme.of(context);
    final isTitle = menu == widget.menu.keys.elementAt(widget.menu.length ~/ 2);

    return GestureDetector(
      onTap: () {
        if (onTapFunction != null) {
          if (onTapFunction is Widget) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => onTapFunction),
            );
          } else {
            onTapFunction();
          }
        }
      },
      child: Container(
        width: isTitle ? 140 : 36,
        child: menu != null
            ? menu is IconData
                ? Icon(menu)
                : Text(
                    menu.toString(),
                    style: isTitle ? theme.textTheme.titleSmall : null,
                    textAlign: TextAlign.center,
                  )
            : const SizedBox(width: 34),
      ),
    );
  }
}
