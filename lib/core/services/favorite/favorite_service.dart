import 'package:hive/hive.dart';
import '/core/services/favorite/models/favorite_model.dart';

class FavoriteService {
  final Box<FavoriteModel> _favoritesBox = Hive.box<FavoriteModel>('favorites');

  List<FavoriteModel> getFavorites() {
    return _favoritesBox.values.toList();
  }

  Future<FavoriteModel?> getFavoriteById(String id) async {
    return _favoritesBox.get(id);
  }

  Future<void> addFavorite(FavoriteModel favorite) async {
    await _favoritesBox.put(favorite.id, favorite);
  }

  Future<void> removeFavorite(String id) async {
    await _favoritesBox.delete(id);
  }

  Future<void> updateFavorite(FavoriteModel favorite) async {
    await _favoritesBox.put(favorite.id, favorite);
  }

  bool isFavorite(String id) {
    return _favoritesBox.containsKey(id);
  }

  //  drop  all favorites
  Future<void> dropFavorites() async {
    await _favoritesBox.clear();
  }
}
