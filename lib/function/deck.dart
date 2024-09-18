import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:project/api/service/factory.dart';
import 'package:project/api/service/model.dart';

class DeckService {
  final Uuid _uuid = Uuid();
  late final String deckID; // สร้าง deckID ขึ้นมาใหม่หากไม่ได้รับค่า
  final String game; // กำหนดชื่อเกมที่ใช้งาน

  // Constructor สำหรับสร้าง DeckService โดยมีการตั้งค่า deckID หากไม่กำหนดจะสร้างใหม่
  DeckService({String? deckID, required this.game}) {
    this.deckID = deckID ?? _uuid.v4();
  }

  // ดึง SharedPreferences เพื่อใช้งาน
  Future<SharedPreferences> _prefs() async {
    return await SharedPreferences.getInstance();
  }

  // ตรวจสอบว่ามีการ์ดที่ระบุอยู่ใน deck แล้วหรือยัง
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

  // บันทึก deck ลงใน SharedPreferences โดยแปลงข้อมูลเป็น JSON
  Future<void> saveDeck(List<Model> deck) async {
    final prefs = await _prefs();
    final savedCards = <String>[];

    for (final card in deck) {
      final cardMap = {
        'game': game,
        'model': card.toJson(),
        'cardCount': card.getCardCount(),
      };
      savedCards.add(jsonEncode(cardMap));
    }

    await prefs.setStringList(deckID, savedCards);
  }

  // โหลด deck จาก SharedPreferences และคืนค่าเป็น List ของ Model
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

  // อัปเดตข้อมูลการ์ดใน deck และบันทึกการเปลี่ยนแปลงลง SharedPreferences
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
            savedCards.removeAt(i); // ลบการ์ดออกหาก cardCount น้อยกว่า 1
          } else {
            savedCards[i] = jsonEncode(cardMap); // อัปเดตการ์ดใน deck
          }

          await prefs.setStringList(deckID, savedCards); // บันทึกการเปลี่ยนแปลง
          return;
        }
      }

      // หากไม่พบการ์ดที่ต้องการอัปเดต จะทำการเพิ่มการ์ดเข้าไปใหม่
      if (!found) {
        await saveDeck([
          ...savedCards.map((card) => jsonDecode(card) as Model),
          card
        ]..lastWhere((model) => model.getName() == card.getName(),
            orElse: () => card));
      }
    }
  }

  // ลบ deck ออกจาก SharedPreferences
  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(deckID); // ลบ deckID ที่บันทึกไว้
  }
}
