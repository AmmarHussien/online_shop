import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;

  List<dynamic> _shoesSize = [];

  int get activePage => _activePage;

  List<dynamic> get shoesSize => _shoesSize;

  List<String> _sizes = [];

  List<String> get sizes => _sizes;

  set activePage(int newIndex) {
    _activePage = newIndex;
    notifyListeners();
  }

  set shoesSize(List<dynamic> newSizes) {
    _shoesSize = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (var i = 0; i < _shoesSize.length; i++) {
      if (i == index) {
        _shoesSize[index]['isSelected'] = !_shoesSize[index]['isSelected'];
      }
    }
    notifyListeners();
  }

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }
}
