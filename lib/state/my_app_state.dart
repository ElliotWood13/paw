import 'package:flutter/material.dart';

class MyAppState extends ChangeNotifier {
  var basket = [];

  void toggleBasket(value) {
    if (basket.contains(value)) {
      basket.remove(value);
    } else {
      basket.add(value);
    }
    notifyListeners();
  }
}
