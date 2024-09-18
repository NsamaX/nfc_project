import 'package:flutter/material.dart';
import 'package:project/api/service/card.dart';
import 'package:project/api/service/model.dart';
import 'package:project/screen/section2/read.dart';
import 'package:project/screen/cardInfo.dart';
import 'package:project/widget/custom/appBar.dart';
import 'package:project/widget/custom/searchBar.dart';
import 'package:project/widget/label/card.dart';

class ScreenSearch extends StatefulWidget {
  final String? game;

  const ScreenSearch({super.key, this.game = ''});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  bool hasMoreData = true;
  late final bool other;
  late final String searchURL;
  int currentPage = 1;
  List<Model> cardList = [];
  List<Model> displayedCards = [];

  @override
  void initState() {
    super.initState();
    other = widget.game!.isEmpty;

    switch (widget.game) {
      case 'cfv':
        searchURL = 'cards?page=';
        break;
      default:
        searchURL = '';
    }

    if (!other) {
      loadAllData();
    }
  }

  Future<void> loadAllData() async {
    while (hasMoreData) {
      await getData(search: searchURL, page: currentPage);
    }
  }

  Future<void> getData({required String search, required int page}) async {
    if (!mounted) return;

    try {
      List<Model> fetchedData = await CardService(game: widget.game!)
          .getData(search: search + page.toString());

      if (!mounted) return;

      setState(() {
        if (fetchedData.isNotEmpty) {
          if (page == 1) {
            cardList = fetchedData;
            displayedCards = filterCards(fetchedData, _searchQuery);
          } else {
            cardList.addAll(fetchedData);
            displayedCards = filterCards(cardList, _searchQuery);
          }
          currentPage = page + 1;
        } else {
          hasMoreData = false;
        }
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  String _searchQuery = '';

  void _updateSearchResults(String query) {
    setState(() {
      _searchQuery = query;
      displayedCards = filterCards(cardList, _searchQuery);
    });
  }

  List<Model> filterCards(List<Model> cards, String query) {
    final lowerCaseQuery = query.toLowerCase();
    if (lowerCaseQuery.isEmpty) {
      return cards;
    }
    return cards
        .where((card) => card.getName().toLowerCase().contains(lowerCaseQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: ScreenRead(),
      !other ? 'Search' : 'Other': null,
      null: null,
      // Icons.filter_alt_rounded: null, ฟิลเตอร์การ์ดที่หา แต่ไว้ทำในอนาคต
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Column(
        children: [
          CustomSearchBar(onSearch: _updateSearchResults),
          SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              itemCount: displayedCards.length,
              itemBuilder: (context, index) {
                final card = displayedCards[index];
                return LabelCard(
                  card: card,
                  page: CardInfoScreen(
                    card: card,
                    page: ScreenSearch(game: widget.game),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
