abstract class Model extends NumberOfCard implements CardInfo {
  Model();
  Model fromJson({required Map<String, dynamic> json});
  Map<String, dynamic> toJson();
}

abstract class CardInfo {
  String getImage();
  String getName();
  Map<String, dynamic> getMap();
}

abstract class NumberOfCard {
  late int cardCount;

  void setCardCount({required int cardCount}) => this.cardCount = cardCount;
  void addCard() => cardCount++;
  void removeCard() => cardCount--;

  int getCardCount() => cardCount;
}
