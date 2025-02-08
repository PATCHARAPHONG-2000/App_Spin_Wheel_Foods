import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  Map<String, Map<String, dynamic>> _cartItems = {};

  Map<String, Map<String, dynamic>> get cartItems => _cartItems;

  int get totalItemCount => _cartItems.length;

  void addItem(String name, String ingredient) {
    if (_cartItems.containsKey(ingredient)) {
      _cartItems[ingredient]!['count']++;
    } else {
      _cartItems[ingredient] = {'name': name, 'count': 1};
    }
    notifyListeners();
  }

  void removeItem(String ingredient) {
    if (_cartItems.containsKey(ingredient) &&
        _cartItems[ingredient]!['count'] > 1) {
      _cartItems[ingredient]!['count']--;
    } else {
      _cartItems.remove(ingredient);
    }
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  List<String> getCartItems() {
    return _cartItems.keys.toList();
  }

  Map<String, int> get menuCounts {
    return _cartItems.map((key, value) => MapEntry(key, value['count']));
  }
}
