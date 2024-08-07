import 'package:flutter/material.dart';

class BasketItem {
  final String product;
  final double value;
  final bool showInBasket;

  BasketItem(
      {required this.product, required this.value, required this.showInBasket});
}

class MyAppState extends ChangeNotifier {
  List<BasketItem> basket = [];

  void toggleBasket(BasketItem item) {
    if (basket.any((element) => element.product == item.product)) {
      basket.removeWhere((element) => element.product == item.product);
    } else {
      basket.add(item);
    }
    notifyListeners();
  }

  double get totalValue {
    return basket.fold(0, (sum, item) => sum + item.value);
  }
}
