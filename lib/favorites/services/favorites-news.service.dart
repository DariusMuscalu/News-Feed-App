import 'package:flutter/widgets.dart';
import 'package:news_app/favorites/repositories/favorites-news.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feed/models/news.model.dart';

// ignore_for_file: constant_identifier_names
const FAVORITE_NEWS_KEY = 'FAVORITE_NEWS';

// TODO REFACTOR IT.
class FavoritesNewsService extends ChangeNotifier {
  static final _favoritesNewsService =
      FavoritesNewsService._privateConstructor();

  factory FavoritesNewsService() => _favoritesNewsService;

  FavoritesNewsService._privateConstructor();

  // === FAVORITES NEWS ID'S ===

  List<String> _favoriteNewsIds = [];

  List<String> get favoriteNewsIds => _favoriteNewsIds;

  void addNewsToFavorites({required String newsId}) => favoriteNewsIds.add(newsId);

  void removeNewsFromFavorites({required String newsId}) => favoriteNewsIds.remove(newsId);

  // === SHARED PREFERENCES ===

  Future<void> addFavoritesNewsIdsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(FAVORITE_NEWS_KEY, favoriteNewsIds);
    notifyListeners();
  }

  Future<void> setFavoritesNewsIdsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteNewsIds = prefs.getStringList(FAVORITE_NEWS_KEY) ?? [];
    notifyListeners();
  }

  // TODO Make it private here and in the feed too.
  // === FAVORITES NEWS BY ID ===
  NewsM? favoriteNewsById;

  void getFavoritesNewsById() async {
    favoriteNewsById = await FavoritesNewsRepository().getFavoritesNewsById(
      id: _favoriteNewsIds[0],
    );

    notifyListeners();
  }
}
