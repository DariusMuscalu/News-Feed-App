import 'package:flutter/cupertino.dart';
import 'package:news_app/feed/models/news-pack.model.dart';
import 'package:news_app/feed/repositories/news-pack.repository.dart';

import '../models/news.model.dart';

class NewsPackProvider extends ChangeNotifier {
  // === NEWS PACK ===
  NewsPackM? newsPack;

  getNewsPackM() async {
    newsPack = await NewsPackRepository().fetchNewsM();
    // TODO Leave comment why it's used how it's used.
    filteredNews = newsPack?.news;
    filteredNewsBySelectedDate = newsPack?.news;

    notifyListeners();
  }

  // === FILTERED NEWS ===
  List<NewsM>? filteredNews;

  // TODO Simplify method name
  void updateFilteredNewsByOrderOfLatestOrHighestDate({required List<NewsM> news}) {
    filteredNews = news;

    notifyListeners();
  }

  // === FILTERED NEWS BY SELECTED DATE ===
  List<NewsM>? filteredNewsBySelectedDate;

  void updateFilteredNewsBySelectedDate({required List<NewsM> news}) {
    filteredNewsBySelectedDate = news;

    notifyListeners();
  }
}
