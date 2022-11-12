import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feed/models/news.model.dart';
import '../repositories/favorites-news.repository.dart';

// ignore_for_file: constant_identifier_names
const FAVORITE_NEWS_IDS_KEY = 'FAVORITE_NEWS_IDS';

// TODO REFACTOR IT.
class FavoritesNewsProvider extends ChangeNotifier {

  // === FAVORITES NEWS ID'S ===

  // We start with an empty list, because at the beginning we will not have any news added to fav.
  List<String> _favoriteNewsIds = [];

  List<String> get favoriteNewsIds => _favoriteNewsIds;

  void addNewsToFavorites({required String newsId}) {
    _favoriteNewsIds.add(newsId);

    notifyListeners();
  }

  void removeNewsFromFavorites({required String newsId}) {
    _favoriteNewsIds.remove(newsId);

    notifyListeners();
  }

  // === SHARED PREFERENCES ===

  Future<void> addFavoritesNewsIdsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(FAVORITE_NEWS_IDS_KEY, _favoriteNewsIds);

    notifyListeners();
  }

  Future<void> getFavoritesNewsIdsFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteNewsIds = prefs.getStringList(FAVORITE_NEWS_IDS_KEY) ?? [];

    notifyListeners();
  }

  Future<void> removeFavoriteNewsIdFromPrefs({required String newsId}) async {
    final prefs = await SharedPreferences.getInstance();

    final favoriteNewsIds = prefs.getStringList(FAVORITE_NEWS_IDS_KEY);
    favoriteNewsIds?.remove(newsId);

    prefs.setStringList(FAVORITE_NEWS_IDS_KEY, favoriteNewsIds ?? []);

    notifyListeners();
  }

  // === FAVORITES NEWS BY ID ===

  List<NewsM>? _favoriteNewsById;

  List<NewsM>? get favoriteNewsById => _favoriteNewsById;

  void fetchFavoritesNewsById() async {
    _favoriteNewsById = [
      for (final id in _favoriteNewsIds)
        await FavoritesNewsRepository().getFavoritesNewsById(
          id: id,
        ),
    ];

    notifyListeners();
  }
}
