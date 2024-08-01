import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var basket = <WordPair>[];

  void toggleBasket() {
    if (basket.contains(current)) {
      basket.remove(current);
    } else {
      basket.add(current);
    }
    notifyListeners();
  }
}
