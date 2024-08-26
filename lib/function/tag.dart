import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:nfc_project/api/service/factory.dart';
import 'package:nfc_project/api/service/model.dart';

class TagService {
  final Uuid _uuid = Uuid();

  Future<void> save({
    required String game,
    required Model card,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTags = prefs.getStringList('tag_card') ?? [];

    final cardMap = {
      'tagId': _uuid.v4(),
      'game': game,
      'model': card.toJson(),
    };

    savedTags.add(jsonEncode(cardMap));
    await prefs.setStringList('tag_card', savedTags);
  }

  Future<List<Model>> load({required String game}) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTags = prefs.getStringList('tag_card');
    final List<Model> tags = [];

    if (savedTags != null) {
      final Set<String> uniqueCardNames = {};

      for (final tag in savedTags) {
        try {
          final cardMap = jsonDecode(tag) as Map<String, dynamic>;
          final model =
              Factory().game(game: game).fromJson(json: cardMap['model']);
          final lowerCaseCardName =
              model.getName().toLowerCase().replaceAll(' ', '');

          if (!uniqueCardNames.contains(lowerCaseCardName)) {
            uniqueCardNames.add(lowerCaseCardName);
            tags.add(model);
          }
        } catch (e) {
          print('Error loading tag: $e');
        }
      }
    }

    return tags;
  }

  Future<void> delete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tag_card');
  }

  Future<void> deleteSpecificCard(String tagId) async {
    final prefs = await SharedPreferences.getInstance();
    final savedTags = prefs.getStringList('tag_card') ?? [];

    savedTags.removeWhere((tag) {
      final cardMap = jsonDecode(tag) as Map<String, dynamic>;
      return cardMap['tagId'] == tagId;
    });

    await prefs.setStringList('tag_card', savedTags);
  }
}
