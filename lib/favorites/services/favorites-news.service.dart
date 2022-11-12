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

  // We start with an empty list, because at the beginning we will not have any news added to fav.
  List<String> _favoriteNewsIds = [];

  List<String> get favoriteNewsIds => _favoriteNewsIds;

  void addNewsToFavorites({required String newsId}) {
    _favoriteNewsIds.add(newsId);

    notifyListeners();
  }

  // TODO Add a method that removes from prefs too.
  void removeNewsFromFavorites({required String newsId}) {
    _favoriteNewsIds.remove(newsId);

    notifyListeners();
  }

  // === SHARED PREFERENCES ===

  Future<void> addFavoritesNewsIdsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(FAVORITE_NEWS_KEY, _favoriteNewsIds);
    notifyListeners();
  }

  Future<void> setFavoritesNewsIdsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteNewsIds = prefs.getStringList(FAVORITE_NEWS_KEY) ?? [];
    notifyListeners();
  }

  Future<void> removeFavoriteNewsIdFromPrefs({required String newsId}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(newsId);

    notifyListeners();
  }

  // === FAVORITES NEWS BY ID ===

  List<NewsM>? _favoriteNewsById;

  List<NewsM>? get favoriteNewsById => _favoriteNewsById;

  void getFavoritesNewsById() async {
    _favoriteNewsById = [
      for (final id in _favoriteNewsIds)
        await FavoritesNewsRepository().getFavoritesNewsById(
          id: id,
        ),
    ];

    notifyListeners();
  }
}
