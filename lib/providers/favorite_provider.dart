import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../repositories/favorite_repository.dart';

class FavoriteProvider extends ChangeNotifier {

  List<Food> _favorites = [];

  final FavoriteRepository favoriteRepository;

  FavoriteProvider({required this.favoriteRepository});

  List<Food> get favorites => _favorites;
  Future<void> getFavorite() async {
    _favorites = await favoriteRepository.fetchFavorite();
    notifyListeners();
  }
  Future<void> ADDFavorite(Food food) async {
    await favoriteRepository.addFavorite(food);
    await getFavorite();
  }
  Future<void> DELFavorite(Food food) async {
   await favoriteRepository.delFavorite(food);
    await getFavorite();
  }
}
