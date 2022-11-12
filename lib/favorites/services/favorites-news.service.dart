import 'package:flutter/widgets.dart';
import 'package:news_app/favorites/repositories/favorites-news.repository.dart';

import '../../feed/models/news.model.dart';

class FavoritesNewsService extends ChangeNotifier {
  static final _favoritesNewsService =
      FavoritesNewsService._privateConstructor();

  factory FavoritesNewsService() => _favoritesNewsService;

  FavoritesNewsService._privateConstructor();

  // TODO Make it private here and in the feed too.
  // === FAVORITES NEWS BY ID ===
  late NewsM favoriteNews;

  bool loading = false;

  void getFavoritesNewsById({required String newsId}) async {
    loading = true;
    favoriteNews = await FavoritesNewsRepository().getFavoritesNewsById(
      id: newsId,
    );
    loading = false;

    notifyListeners();
  }
}
