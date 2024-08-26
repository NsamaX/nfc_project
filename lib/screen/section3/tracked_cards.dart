import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/model.dart';
import 'package:nfc_project/function/tag.dart';
import 'package:nfc_project/screen/section3/setting.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/bottomNav.dart';
import 'package:nfc_project/widget/custom/card.dart';

class TrackedScreen extends StatefulWidget {
  const TrackedScreen({super.key});

  @override
  State<TrackedScreen> createState() => _TrackedScreenState();
}

class _TrackedScreenState extends State<TrackedScreen> {
  final bool TestSystem = true;
  List<Model> Tags = [];

  @override
  void initState() {
    super.initState();
    loadTrackedCards();
  }

  Future<void> loadTrackedCards() async {
    final cards = await TagService().load(game: 'cfv');
    setState(() {
      Tags = cards;
    });
  }

  void delete() {
    if (Tags.isEmpty) return;
    TagService().delete().then(
      (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleted all tags successfully')),
        );
        setState(() {
          Tags = [];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: SettingScreen(),
      'Tracked': null,
      TestSystem ? Icons.delete_rounded : null: delete,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: Tags.length,
        itemBuilder: (context, index) {
          return CustomCard(
            card: Tags[index],
            page: CardInfoScreen(
              card: Tags[index],
              page: TrackedScreen(),
              isAdd: false,
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 2),
    );
  }
}
