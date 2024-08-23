import 'package:flutter/material.dart';
import 'package:nfc_project/screen/card_info.dart';
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
  bool history = false;
  bool game = false;
  bool nfc = false;

  final List<Map<String, dynamic>> history_log = List.generate(30, (index) {
    final String imagePath = 'asset/image/icon_flutter.png';
    return {
      'name': 'Card name ${index + 1}',
      'content': [
        {
          'image': imagePath,
          'detail': 'Description',
          'page': CardInfoScreen(
            imagePath: imagePath,
            page: ReadWriteScreen(),
            isAdd: true,
          ),
        },
      ]
    };
  });

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.history_rounded: _toggleHistoryMenu,
      'Read': null,
      Icons.handyman_rounded: _toggleGameMenu,
    };
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GestureDetector(
        onTap: () {
          if (history || game) {
            setState(() {
              history = false;
              game = false;
            });
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Stack(
          children: [
            Center(
              child: NFC(
                isNFCDetected: nfc,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: history ? 0 : -100,
              child: HistoryBox(
                historyLog: history_log,
                historyBoxHeight: screenHeight,
                historyBoxVisible: history,
              ),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              top: 20,
              right: game ? 0 : -100,
              child: OpionBox(
                optionBoxVisible: game,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 1),
    );
  }

  void _toggleHistoryMenu() {
    setState(() {
      history = !history;
      if (history) game = false;
    });
  }

  void _toggleGameMenu() {
    setState(() {
      game = !game;
      if (game) history = false;
    });
  }
}
