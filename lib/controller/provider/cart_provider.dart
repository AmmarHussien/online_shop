import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CartNotifier extends ChangeNotifier {
  int _counter = 0;

  int get countter => _counter;

  final _cartBox = Hive.box('cart_box');

  List<dynamic> _cart = [];

  List<dynamic> get cart => _cart;

  set cart(List<dynamic> newCart) {
    _cart = newCart;
    notifyListeners();
  }

  getCart() {
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        'key': key,
        'id': item['id'],
        'category': item['category'],
        'name': item['name'],
        'imageUrl': item['imageUrl'],
        'price': item['price'],
        'qty': item['qty'],
        'sizes': item['sizes'],
      };
    }).toList();

    _cart = cartData.reversed.toList();
  }

  Future<void> deleteCart(int key) async {
    await _cartBox.delete(key);
  }

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    if (_counter >= 1) {
      _counter--;
      notifyListeners();
    }
  }
}
