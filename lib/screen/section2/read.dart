import 'package:flutter/material.dart';
import 'package:project/widget/boxDrawer/history.dart';
import 'package:project/widget/boxDrawer/option.dart';
import 'package:project/widget/custom/appBar.dart';
import 'package:project/widget/custom/bottomNav.dart';
import 'package:project/widget/NFC.dart';

class ScreenRead extends StatefulWidget {
  const ScreenRead({super.key});

  @override
  State<ScreenRead> createState() => _ScreenReadState();
}

class _ScreenReadState extends State<ScreenRead> {
  bool nfc = false;
  bool history = false;
  bool option = false;

  void toggleHistoryMenu() {
    setState(() {
      history = !history;
      if (history) option = false;
    });
  }

  void toggleOptionMenu() {
    setState(() {
      option = !option;
      if (option) history = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.history_rounded: toggleHistoryMenu,
      'Read': null,
      Icons.handyman_rounded: toggleOptionMenu,
    };
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GestureDetector(
        onTap: () {
          if (history || option) {
            setState(() {
              history = false;
              option = false;
            });
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Center(
              child: NFC(NFCDetected: nfc),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: history ? 0 : -100,
              child: BoxHistory(
                BoxHistoryVisible: history,
                BoxHistoryHeight: screenHeight,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: 20,
              right: option ? 0 : -100,
              child: BoxOption(BoxOptionVisible: option),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 1),
    );
  }
}
