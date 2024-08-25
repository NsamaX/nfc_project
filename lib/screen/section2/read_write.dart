import 'package:flutter/material.dart';
import 'package:nfc_project/widget/boxDrawer/history.dart';
import 'package:nfc_project/widget/boxDrawer/option.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/NFC.dart';

class ReadWriteScreen extends StatefulWidget {
  const ReadWriteScreen({super.key});

  @override
  State<ReadWriteScreen> createState() => _ReadWriteScreenState();
}

class _ReadWriteScreenState extends State<ReadWriteScreen> {
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
              child: NFC(isNFCDetected: nfc),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: history ? 0 : -100,
              child: HistoryBox(
                historyBoxVisible: history,
                historyBoxHeight: screenHeight,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: 20,
              right: option ? 0 : -100,
              child: OptionBox(optionBoxVisible: option),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 1),
    );
  }
}
