import 'package:flutter/material.dart';
import 'package:nfc_project/screen/card_info.dart';
import 'package:nfc_project/widget/boxDrawer/history.dart';
import 'package:nfc_project/widget/boxDrawer/option.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/NFC.dart';

class ReadScreen extends StatefulWidget {
  const ReadScreen({super.key});

  @override
  State<ReadScreen> createState() => _ReadScreenState();
}

class _ReadScreenState extends State<ReadScreen> {
  bool history = false;
  bool game = false;
  bool nfc = false;

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
              top: history ? 0 : -screenHeight,
              left: 0,
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

final List<Map<String, dynamic>> history_log = List.generate(30, (index) {
  final String imagePath = 'asset/image/Nightrose.png';
  return {
    'name': 'Arisa Mihairovuna Kujō ${index + 1}',
    'content': [
      {
        'image': imagePath,
        'detail': 'Detail ${index + 1}',
        'page': CardInfoScreen(
          imagePath: imagePath,
          page: ReadScreen(),
          isAdd: true,
        ),
      },
    ]
  };
});
