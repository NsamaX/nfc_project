import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/card.dart';
import 'package:nfc_project/api/service/model.dart';
import 'package:nfc_project/screen/section2/readWrite.dart';
import 'package:nfc_project/screen/cardInfo.dart';
import 'package:nfc_project/widget/custom/appBar.dart';
import 'package:nfc_project/widget/custom/searchBar.dart';
import 'package:nfc_project/widget/label/card.dart';

class SearchScreen extends StatefulWidget {
  final String? game;

  const SearchScreen({super.key, this.game = ''});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController scrollController = ScrollController();
  bool isLoading = false;

  late final bool other;
  late final String search;
  int currentPage = 1;
  List<Model> cardList = [];

  @override
  void initState() {
    super.initState();
    other = widget.game!.isEmpty;

    switch (widget.game) {
      case 'cfv':
        search = 'cards?page=';
        break;
      default:
        search = '';
    }

    if (!other) {
      scrollController.addListener(scrollListener);
      getData(search: search, page: currentPage);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange &&
        !isLoading) {
      getData(search: search, page: currentPage);
    }
  }

  Future<void> getData({required String search, required int page}) async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      List<Model> fetchedData = await CardService(game: widget.game!)
          .getData(search: search + page.toString());

      if (!mounted) return;

      setState(() {
        if (page == 1) {
          cardList = fetchedData;
        } else {
          cardList.addAll(fetchedData);
        }
        currentPage = page + 1;
      });
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<dynamic, dynamic> menu = {
      Icons.arrow_back_ios_rounded: ReadWriteScreen(),
      !other ? 'Search' : 'Other': null,
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
