import 'package:nfc_project/api/game/cfv.dart';
import 'package:nfc_project/api/game/model.dart';

class Factory {
  Model game({required String game}) {
    switch (game) {
      case 'cfv':
        return CFV();
      default:
        throw Exception('Unsupported game: $game');
    }
  }
}
