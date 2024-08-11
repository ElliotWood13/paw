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
  String _catName = '';
  String _catGender = '';
  String _catBreed = '';
  DateTime? _catAge;
  bool? _catDeSexed;
  String _ownerName = '';
  DateTime? _ownerDob;
  String _ownerAddress = '';
  DateTime? _startDate;
  String get catName => _catName;
  String get catGender => _catGender;
  String get catBreed => _catBreed;
  DateTime? get catAge => _catAge;
  bool? get catDeSexed => _catDeSexed;
  String get ownerName => _ownerName;
  DateTime? get ownerDob => _ownerDob;
  String get ownerAddress => _ownerAddress;
  DateTime? get startDate => _startDate;

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

  void setCatName(String name) {
    _catName = name;
    notifyListeners();
  }

  void setCatGender(String gender) {
    _catGender = gender;
    notifyListeners();
  }

  void setCatBreed(String breed) {
    _catBreed = breed;
    notifyListeners();
  }

  void setCatAge(DateTime? age) {
    _catAge = age;
    notifyListeners();
  }

  void setCatDeSexed(bool? deSexed) {
    _catDeSexed = deSexed;
    notifyListeners();
  }

  void setOwnerName(String name) {
    _ownerName = name;
    notifyListeners();
  }

  void setOwnerDob(DateTime? dob) {
    _ownerDob = dob;
    notifyListeners();
  }

  void setOwnerAddress(String address) {
    _ownerAddress = address;
    notifyListeners();
  }

  void setStartDate(DateTime? date) {
    _startDate = date;
    notifyListeners();
  }
}
