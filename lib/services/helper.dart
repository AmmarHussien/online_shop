import 'package:flutter/services.dart' as the_bundle;
import 'package:online_shop/models/sneaker_model.dart';

class Helper {
  //All Male
  Future<List<Sneakers>> getMaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);

    return maleList;
  }

  //All Female
  Future<List<Sneakers>> getFemaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');
    final femaleList = sneakersFromJson(data);

    return femaleList;
  }

  //All kids
  Future<List<Sneakers>> getKidsSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');
    final kidsList = sneakersFromJson(data);

    return kidsList;
  }

  //single Male
  Future<Sneakers> getMaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/men_shoes.json');

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  //single Female
  Future<Sneakers> getFemaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/women_shoes.json');

    final femaleList = sneakersFromJson(data);

    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  //single Kids
  Future<Sneakers> getKidsSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString('assets/json/kids_shoes.json');

    final kidsList = sneakersFromJson(data);

    final sneaker = kidsList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }
}
