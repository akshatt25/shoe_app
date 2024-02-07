import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  List<Map<String, dynamic>> cart = [];
  static const String _cartKey = 'cart';

  CartProvider() {
    loadCartFromPrefs(); // Load cart data during initialization
  }

  Future<void> loadCartFromPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      cart = List<Map<String, dynamic>>.from(json.decode(cartString));
      notifyListeners();
    }
  }

  Future<void> _saveCartToPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String cartString = json.encode(cart);
    await prefs.setString(_cartKey, cartString);
  }

  void addProduct(Map<String, dynamic> product) {
    cart.add(product);
    _saveCartToPrefs();
    notifyListeners();
  }

  void removeProduct(Map<String, dynamic> product) {
    cart.remove(product);
    _saveCartToPrefs();
    notifyListeners();
  }

  List<Map<String, dynamic>> getSavedCartItems() {
    return List<Map<String, dynamic>>.from(cart);
  }
}
