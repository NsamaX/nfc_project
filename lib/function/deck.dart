import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:nfc_project/api/service/factory.dart';
import 'package:nfc_project/api/service/model.dart';

class DeckService {
  final Uuid _uuid = Uuid();
  late final String deckID;
  final String game;

  DeckService({String? deckID, required this.game}) {
    this.deckID = deckID ?? _uuid.v4();
  }

  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> check({required String cardName}) async {
    final prefs = await _prefs();
    final savedCards = prefs.getStringList(deckID);

    if (savedCards != null) {
      final lowerCaseCardName = cardName.toLowerCase().replaceAll(' ', '');

      for (final card in savedCards) {
        final cardMap = jsonDecode(card) as Map<String, dynamic>;
        final model =
            Factory().game(game: game).fromJson(json: cardMap['model']);
        final lowerCaseExistingCardName =
            model.getName().toLowerCase().replaceAll(' ', '');

        if (lowerCaseExistingCardName == lowerCaseCardName) return true;
      }
    }

    return false;
  }

  Future<void> save({
    required Model card,
    required int cardCount,
  }) async {
    if (await check(cardName: card.getName())) return;

    final prefs = await _prefs();
    final savedCards = prefs.getStringList(deckID) ?? [];

    final cardMap = {
      'game': game,
      'model': card.toJson(),
      'cardCount': cardCount,
    };

    savedCards.add(jsonEncode(cardMap));
    await prefs.setStringList(deckID, savedCards);
  }

  Future<List<Model>> load() async {
    final prefs = await _prefs();
    final savedCards = prefs.getStringList(deckID);
    final Map<String, Model> cardsByName = {};

    if (savedCards != null) {
      for (final card in savedCards) {
        try {
          final cardData = jsonDecode(card) as Map<String, dynamic>;
          final model =
              Factory().game(game: game).fromJson(json: cardData['model']);
          final cardCount = cardData['cardCount'] as int;

          final lowerCaseCardName =
              model.getName().toLowerCase().replaceAll(' ', '');

          if (cardsByName.containsKey(lowerCaseCardName)) {
            cardsByName[lowerCaseCardName]!.addCard();
          } else {
            model.setCardCount(cardCount: cardCount);
            cardsByName[lowerCaseCardName] = model;
          }
        } catch (e) {
          print('Error loading card: $e');
        }
      }
    }

    return cardsByName.values.toList();
  }

  Future<void> update({
    required Model card,
    required int cardCount,
  }) async {
    final prefs = await _prefs();
    final savedCards = prefs.getStringList(deckID);

    if (savedCards != null) {
      bool found = false;

      for (int i = 0; i < savedCards.length; i++) {
        final cardMap = jsonDecode(savedCards[i]) as Map<String, dynamic>;
        final model =
            Factory().game(game: game).fromJson(json: cardMap['model']);

        if (model.getName() == card.getName()) {
          found = true;
          model.setCardCount(cardCount: cardCount);

          cardMap['model'] = model.toJson();
          cardMap['cardCount'] = cardCount;

          if (cardCount < 1) {
            savedCards.removeAt(i);
          } else {
            savedCards[i] = jsonEncode(cardMap);
          }

          await prefs.setStringList(deckID, savedCards);
          return;
        }
      }

      if (!found) {
        await save(card: card, cardCount: cardCount);
      }
    }
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(deckID);
  }
}
