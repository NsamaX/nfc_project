import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nfc_project/api/service/factory.dart';
import 'package:nfc_project/api/service/model.dart';

class DeckService {
  Future<bool> check({
    required String game,
    required String cardName,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCards = prefs.getStringList('user_deck');

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

  Future<List<Model>> load({required String game}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCards = prefs.getStringList('user_deck');
    final List<Model> deck = [];

    if (savedCards != null) {
      for (final card in savedCards) {
        final cardMap = jsonDecode(card) as Map<String, dynamic>;
        final model =
            Factory().game(game: game).fromJson(json: cardMap['model']);
        final cardCount = cardMap['cardCount'] as int;

        model.setCardCount(cardCount: cardCount);
        deck.add(model);
      }
    }

    return deck;
  }

  Future<void> save({
    required String game,
    required Model card,
    required int cardCount,
  }) async {
    if (await check(game: game, cardName: card.getName())) return;

    final prefs = await SharedPreferences.getInstance();
    final savedCards = prefs.getStringList('user_deck') ?? [];

    final cardMap = {
      'game': game,
      'model': card.toJson(),
      'cardCount': cardCount,
    };

    savedCards.add(jsonEncode(cardMap));
    await prefs.setStringList('user_deck', savedCards);
  }

  Future<void> update({
    required String game,
    required Model card,
    required int cardCount,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedCards = prefs.getStringList('user_deck');

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

          await prefs.setStringList('user_deck', savedCards);
          return;
        }
      }

      if (!found) {
        await save(game: game, card: card, cardCount: cardCount);
      }
    }
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_deck');
  }
}
