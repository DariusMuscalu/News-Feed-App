import 'package:flutter/material.dart';
import 'package:news_app/feed/models/news.model.dart';
import 'package:news_app/feed/providers/news-pack.provider.dart';
import 'package:news_app/shared/const/template-dimensions.const.dart';
import 'package:news_app/shared/widgets/buttons/button.dart';
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
  @override
  void initState() {
    // Gets the news pack which holds all the news.
    Provider.of<NewsPackProvider>(context, listen: false).getNewsPackM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Consumer<NewsPackProvider>(
        builder: (context, newsPackService, children) {
          return PageShell(
            appBarChild: newsPackService.newsPack != null
                ? _searchBar(
                    allNews: newsPackService.newsPack!.news,
                  )
                : SPINKIT,
            children: <Widget>[
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

  Widget _searchBar({required List<NewsM> allNews}) => Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: (value) => _runFilter(
                enteredKeyword: value,
                allNews: allNews,
              ),
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Row(
            children: [
              Button(
                onTap: () => _sortNewsByNumberOfPoints(
                  descendant: false,
                  allNews: allNews,
                ),
                name: 'Ascending',
                color: Colors.green,
                bgrColor: Colors.lightGreen,
              ),
              Button(
                onTap: () => _sortNewsByNumberOfPoints(
                  descendant: true,
                  allNews: allNews,
                ),
                name: 'Descending',
                color: Colors.green,
                bgrColor: Colors.lightGreen,
              ),
              Button(
                onTap: () => _sortNewsByDate(
                  allNews: allNews,
                  descendant: false,
                ),
                name: 'Oldest date sort',
                color: Colors.green,
                bgrColor: Colors.lightGreen,
              ),
              Button(
                onTap: () => _sortNewsByDate(
                  allNews: allNews,
                  descendant: true,
                ),
                name: 'Latest date sort',
                color: Colors.green,
                bgrColor: Colors.lightGreen,
              ),
            ],
          ),
        ],
      );

  Widget _scrollableList({required List<Widget> children}) => Expanded(
        child: Container(
          color: Colors.blue,
          child: ListView(
            controller: ScrollController(),
            children: children,
          ),
        ),
      );

  // TODO Improve the logic of this method.
  // TODO Extract this method from here, create an controller.
  void _runFilter({
    required String enteredKeyword,
    required List<NewsM> allNews,
  }) {
    final List<NewsM> news;

    if (enteredKeyword.isEmpty) {
      // If the search field is empty we'll set the filtered news to all news and exit.
      Provider.of<NewsPackProvider>(context, listen: false).updateFilteredNews(
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

    // Update the UI
    Provider.of<NewsPackProvider>(context, listen: false).updateFilteredNews(
      news: news,
    );
  }

  // Sort news based on number of points.
  // From lowest to highest or highest to lowest if it's descendant.
  void _sortNewsByNumberOfPoints({
    required List<NewsM> allNews,
    required bool descendant,
  }) {
    List<NewsM> sortedNews = allNews;
    // TODO Add null safety
    sortedNews.sort((a, b) => (a.numberOfPoints! - b.numberOfPoints!));

    List<NewsM> sortNewsByHighestNumberOfPoints = sortedNews.reversed.toList();

    // Update news.
    Provider.of<NewsPackProvider>(context, listen: false).updateFilteredNews(
      news: descendant ? sortNewsByHighestNumberOfPoints : sortedNews,
    );
  }

  // Sort news by date in ascending or descending order.
  void _sortNewsByDate({
    required List<NewsM> allNews,
    required bool descendant,
  }) {
    // TODO Rename
    List<NewsM> sortedNews = allNews;

    sortedNews.sort(
        (a, b) => a.publishDate.toString().compareTo(b.publishDate.toString()));

    List<NewsM> sortedByLatestDate = sortedNews.reversed.toList();

    // Update news.
    Provider.of<NewsPackProvider>(context, listen: false).updateFilteredNews(
      news: descendant ? sortedByLatestDate : sortedNews,
    );
  }
}
