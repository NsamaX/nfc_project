abstract class Model extends Count implements Info {
  Model();
  Model fromJson({required Map<String, dynamic> json});
  Map<String, dynamic> toJson();
}

abstract class Info {
  String getName();
  String getImagePath();
  String getDescription();
  Map<String, dynamic> getMap();
}

abstract class Count {
  int cardCount = 0;
  void addCard() => cardCount++;
  void removeCard() => cardCount--;
  void setCardCount({required int cardCount}) => this.cardCount = cardCount;
  int getCardCount() => cardCount;
}
