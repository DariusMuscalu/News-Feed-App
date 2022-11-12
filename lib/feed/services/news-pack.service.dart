import 'package:flutter/cupertino.dart';
import 'package:news_app/feed/models/news-pack.model.dart';
import 'package:news_app/feed/repositories/news-pack.repository.dart';

import '../models/news.model.dart';

class NewsPackService extends ChangeNotifier {
  // === NEWS PACK ===
  NewsPackM? newsPack;

  getNewsPackM() async {
    newsPack = await NewsPackRepository().fetchNewsM();
    // TODO Leave comment why it's used how it's used.
    filteredNews = newsPack?.news;

    notifyListeners();
  }

  // === FILTERED NEWS ===
  List<NewsM>? filteredNews;

  void updateFilteredNews({required List<NewsM> news}) {
    filteredNews = news;

    notifyListeners();
  }
}
