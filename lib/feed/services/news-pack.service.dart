import 'package:flutter/cupertino.dart';
import 'package:news_app/feed/models/news-pack.model.dart';
import 'package:news_app/feed/repositories/news-pack.repository.dart';

class NewsPackService extends ChangeNotifier {
  // TODO This should be null. The server might return nothing, take that in consideration always.
  late NewsPackM newsPack;

  // Todo improve this with something better, a convention through all services.
  bool loading = false;

  getNewsPackM() async {
    loading = true;
    newsPack = (await NewsPackRepository().fetchNewsM());
    loading = false;

    // Tells the change notifier to update when changes are made and such, the UI is updated with the new data.
    // TODO The above comment should be understood without needing a comment if you understand the provider state management API
    notifyListeners();
  }
}
