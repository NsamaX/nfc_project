import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/cards.dart';
import 'package:nfc_project/api/service/model.dart';
import 'package:nfc_project/screen/section2/readWrite.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/searchBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class SearchScreen extends StatefulWidget {
  final bool other;

  const SearchScreen({super.key, this.other = false});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  final String search = "cards?page=";
  int currentPage = 1;

  List<Model> cardList = [];

  @override
  void initState() {
    if (!widget.other) {
      scrollController.addListener(scrollListener);
      getData(search: search, page: currentPage);
    }
    super.initState();
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      getData(search: search, page: currentPage);
    }
  }

  Future<void> getData({required String search, required int page}) async {
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    List<Model> fetchedData = await CardsService(game: 'cfv')
        .getData(game: 'cfv', search: search + page.toString());
    if (!mounted) return;
    setState(() {
      if (page == 1)
        cardList = fetchedData;
      else
        cardList.addAll(fetchedData);
      currentPage = page + 1;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: ReadWriteScreen(),
      !widget.other ? 'Search' : 'Other': null,
      null: null,
    };

    return Scaffold(
      appBar: CustomAppBar(menu: menu),
      body: Column(
        children: [
          CustomSearchBar(),
          SizedBox(height: 6),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: cardList.length,
              itemBuilder: (context, index) {
                final card = cardList[index];
                return LabelCard(
                  card: card,
                  page: CardInfoScreen(
                    card: card,
                    page: SearchScreen(),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
