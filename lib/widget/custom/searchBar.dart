import 'package:flutter/material.dart';
import 'package:nfc_project/api/service/model.dart';

class CustomSearchBar extends StatefulWidget {
  final List<Model> allCards;
  final Function(List<Model>) onSearchResults;

  const CustomSearchBar({
    super.key,
    required this.allCards,
    required this.onSearchResults,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final searchQuery = _searchController.text.toLowerCase();
    final searchResults = widget.allCards.where((card) {
      final cardName = card.getName().toLowerCase();
      return cardName.contains(searchQuery);
    }).toSet();

    widget.onSearchResults(searchResults.toList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      color: Theme.of(context).appBarTheme.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 6),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.black),
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Colors.black,
                  ),
                  hintText: 'Search...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () {
                FocusScope.of(context).unfocus();
                _searchController.clear();
                widget.onSearchResults(widget.allCards.toSet().toList());
              },
              child: Text(
                'Cancel',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Theme.of(context).secondaryHeaderColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
