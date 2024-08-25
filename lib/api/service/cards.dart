import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nfc_project/api/service/factory.dart';
import 'package:nfc_project/api/service/model.dart';

class CardService {
  final String game;
  late final String baseUrl;

  CardService({required String game}) : game = game {
    switch (game) {
      case 'cfv':
        // https://card-fight-vanguard-api.ue.r.appspot.com
        baseUrl = "https://card-fight-vanguard-api.ue.r.appspot.com/api/v1/";
        break;
      default:
        throw ArgumentError('Unsupported game: $game');
    }
  }

  Future<List<Model>> getData({
    required String game,
    required String search,
  }) async {
    http.Response response = await http.get(Uri.parse(baseUrl + search));
    try {
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body)['data'];
        List<Model> fetchedData = jsonData
            .map((e) => Factory().game(game: game).fromJson(json: e))
            .toList();
        switch (game) {
          case 'cfv':
            fetchedData.removeWhere((item) => item.getMap()['Sets'] == null);
            break;
          default:
            throw ArgumentError('Unsupported game: $game');
        }
        return fetchedData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }
}
