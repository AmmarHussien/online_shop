import 'package:flutter/material.dart';
import 'package:online_shop/models/sneaker_model.dart';
import 'package:online_shop/services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  int _activePage = 0;

  List<dynamic> _shoesSize = [];

  int get activePage => _activePage;

  List<dynamic> get shoesSize => _shoesSize;

  List<String> _sizes = [];

  List<String> get sizes => _sizes;


  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;

  void getMale() {
    male = Helper().getMaleSneaker();
  }

  void getFemale() {
    female = Helper().getFemaleSneaker();
  }

  void getKids() {
    kids = Helper().getKidsSneaker();
  }

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

  late Future<Sneakers> sneaker;

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakerById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakerById(id);
    } else if (category == "Kids' Running") {
      sneaker = Helper().getKidsSneakerById(id);
    }
  }

 
}
