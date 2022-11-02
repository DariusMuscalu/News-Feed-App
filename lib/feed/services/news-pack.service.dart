import 'package:flutter/cupertino.dart';
import 'package:news_app/feed/models/news-pack.model.dart';
import 'package:news_app/feed/repositories/news-pack.repository.dart';

class NewsPackService extends ChangeNotifier {
  NewsPackM? newsPack;
  // Todo improve this with something better, a convention through all services.
  bool loading = false;

  getNewsPackM() async {
    loading = true;
    newsPack = (await NewsPackRepository().fetchNewsM());
    loading = false;

    // Tells the change notifier to update when changes are made and such, the UI is updated with the new data.
    notifyListeners();
  }

}