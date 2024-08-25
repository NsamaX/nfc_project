import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nfc_project/api/service/factory.dart';
import 'package:nfc_project/api/service/model.dart';

class DeckService {
  Future<bool> check({
    required String game,
    required String cardName,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCards = prefs.getStringList('user_deck');
    if (savedCards != null) {
      String lowerCaseCardName = cardName.toLowerCase().replaceAll(' ', '');
      for (String card in savedCards) {
        Map<String, dynamic> cardMap = jsonDecode(card);
        Model data =
            Factory().game(game: game).fromJson(json: cardMap['model']);
        String lowerCaseExistingCardName =
            data.getName().toLowerCase().toLowerCase().replaceAll(' ', '');
        if (lowerCaseExistingCardName == lowerCaseCardName) return true;
      }
    }
    return false;
  }

  Future<List<Model>> load({required String game}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCards = prefs.getStringList('user_deck');
    List<Model> deck = [];
    if (savedCards != null)
      for (String card in savedCards) {
        Map<String, dynamic> cardMap = jsonDecode(card);
        Model data =
            Factory().game(game: game).fromJson(json: cardMap['model']);
        int cardCount = cardMap['cardCount'];
        data.setCardCount(cardCount: cardCount);
        deck.add(data);
      }
    return deck;
  }

  Future<void> save({
    required String game,
    required Model card,
    required int cardCount,
  }) async {
    if (await check(game: game, cardName: card.getName())) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> savedCards = prefs.getStringList('user_deck') ?? [];
    Map<String, dynamic> cardMap = {
      'game': game,
      'model': card.toJson(),
      'cardCount': cardCount,
    };
    String cardJson = jsonEncode(cardMap);
    savedCards.add(cardJson);
    await prefs.setStringList('user_deck', savedCards);
    print('saved');
  }

  Future<void> update({
    required String game,
    required Model card,
    required int cardCount,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedCards = prefs.getStringList('user_deck');
    if (savedCards != null) {
      bool found = false;
      for (int i = 0; i < savedCards.length; i++) {
        Map<String, dynamic> cardMap = jsonDecode(savedCards[i]);
        Model data =
            Factory().game(game: game).fromJson(json: cardMap['model']);
        if (data.getName() == card.getName()) {
          found = true;
          data.setCardCount(cardCount: cardCount);
          cardMap['model'] = data.toJson();
          cardMap['cardCount'] = cardCount;
          if (cardCount < 1)
            savedCards.removeAt(i);
          else {
            String updatedCardJson = jsonEncode(cardMap);
            savedCards[i] = updatedCardJson;
          }
          await prefs.setStringList('user_deck', savedCards);
          return;
        }
      }
      if (!found) save(game: game, card: card, cardCount: cardCount);
    }
  }

  Future<void> delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_deck');
  }
}
