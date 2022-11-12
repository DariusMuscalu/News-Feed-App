import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feed/models/news.model.dart';
import 'package:news_app/feed/services/news-pack.service.dart';
import 'package:news_app/feed/state/feed.state.dart';
import 'package:news_app/shared/const/template-dimensions.const.dart';
import 'package:news_app/shared/widgets/cards/news-card.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';

// This is the main feed that is showing the latest news.
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final _feedState = FeedState();

  @override
  void initState() {
    Provider.of<NewsPackService>(context, listen: false).getNewsPackM();
    _feedState.setFavoritesNewsToPrefs();
    super.initState();
  }

  // TODO Order method in this file by the order in the build method.
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsPackService>(
      builder: (context, newsPackService, children) {
        return PageShell(
          appBarChild: newsPackService.newsPack != null
              ? _searchBar(
                  allNews: newsPackService.newsPack!.news,
                )
              : SPINKIT,
          children: <Widget>[
            _buttonsCol(
              context,
            ),
            newsPackService.filteredNews == null
                ? SPINKIT
                : _scrollableList(
                    children: [
                      for (final news in newsPackService.filteredNews ?? [])
                        NewsCard(
                          news: news,
                        ),
                    ],
                  ),
          ],
        );
      },
    );
  }

  Widget _searchBar({required List<NewsM> allNews}) => TextField(
        onChanged: (value) => _runFilter(
          enteredKeyword: value,
          allNews: allNews,
        ),
        decoration: const InputDecoration(
          labelText: 'Search',
          suffixIcon: Icon(Icons.search),
        ),
      );

  // TODO Improve the logic of this method.
  void _runFilter({
    required String enteredKeyword,
    required List<NewsM> allNews,
  }) {
    final List<NewsM> news;

    if (enteredKeyword.isEmpty) {
      // If the search field is empty we'll set the filtered news to all news and exit.
      Provider.of<NewsPackService>(context, listen: false).updateFilteredNews(
        news: allNews,
      );
      return;
    } else {
      news = allNews
          .where((news) => (news.title != null ? news.title! : '')
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // We use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    Provider.of<NewsPackService>(context, listen: false).updateFilteredNews(
      news: news,
    );
  }

  Widget _buttonsCol(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
          onPressed: () => context.go('/favorites'),
          child: const Text('Go to favorites page'),
        ),
        ElevatedButton(
          onPressed: () => context.go('/calendar'),
          child: const Text('Go to calendar page'),
        ),
      ],
    );
  }

  Widget _scrollableList({required List<Widget> children}) => Expanded(
        child: Container(
          color: Colors.blue,
          child: ListView(
            controller: ScrollController(),
            children: children,
          ),
        ),
      );
}
