import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore_for_file: constant_identifier_names
const FAVORITE_NEWS_KEY = 'FAVORITE_NEWS';

class FeedState extends ChangeNotifier {
  static final FeedState _feedState = FeedState._privateConstructor();

  factory FeedState() => _feedState;

  FeedState._privateConstructor();

  // === FAVORITES NEWS ID'S ===

  List<String> _favoriteNewsIds = [];

  List<String> get favoriteNewsIds => _favoriteNewsIds;

  void addNewsToFavorites({required String newsId}) => favoriteNewsIds.add(newsId);

  void removeNewsFromFavorites({required String newsId}) => favoriteNewsIds.remove(newsId);

  // === SHARED PREFERENCES ===

  // TODO Add const for 'favoriteNews'
  Future<void> addFavoritesNewsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(FAVORITE_NEWS_KEY, favoriteNewsIds);
    notifyListeners();
  }

  Future<void> setFavoritesNewsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    _favoriteNewsIds = prefs.getStringList(FAVORITE_NEWS_KEY) ?? [];
    notifyListeners();
  }

// === FEED NEWS ===
}
