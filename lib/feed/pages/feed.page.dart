import 'package:flutter/material.dart';
import 'package:news_app/feed/models/news.model.dart';
import 'package:news_app/feed/providers/news-pack.provider.dart';
import 'package:news_app/shared/const/template-dimensions.const.dart';
import 'package:news_app/shared/widgets/buttons/button.dart';
import 'package:news_app/shared/widgets/cards/news-card.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';

import '../../favorites-news/providers/favorites-news.provider.dart';

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
    // Gets the favorites, if any, from the prefs.
    Provider.of<FavoritesNewsProvider>(context, listen: false)
        .getFavoritesNewsIdsFromPrefs();
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
                : const SizedBox(),
            children: <Widget>[
              newsPackService.newsPack != null
                  ? _dropdownButtons(
                      newsPackService.newsPack!.news,
                    )
                  : const SizedBox(),
              newsPackService.filteredNews == null
                  ? SPINKIT
                  : _scrollableList(
                      children: [
                        for (final news
                            in newsPackService.filteredNews ?? <NewsM>[])
                          NewsCard(
                            news: news,
                          ),
                      ],
                    ),
            ],
          );
        },
      );

  Widget _searchBar({required List<NewsM> allNews}) => Expanded(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: 45,
          child: TextField(
            cursorColor: Colors.white,
            onChanged: (value) => _runFilter(
              enteredKeyword: value,
              allNews: allNews,
            ),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            decoration: const InputDecoration(
              labelText: 'Search',
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              suffixIcon: Icon(Icons.search),
              suffixIconColor: Colors.redAccent,
              focusedBorder: OutlineInputBorder(
                borderRadius: BORDER_RADIUS,
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white70,
                ),
                borderRadius: BORDER_RADIUS,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white70,
                ),
                borderRadius: BORDER_RADIUS,
              ),
            ),
          ),
        ),
      );

  // TODO Ain't dropdown, modify name.
  Widget _dropdownButtons(List<NewsM> allNews) => Wrap(
        children: [
          _dropdownButton(
            name: 'Lowest Number Of Points',
            onTap: () => _sortNewsByNumberOfPoints(
              descendant: false,
              allNews: allNews,
            ),
          ),
          _dropdownButton(
            name: 'Highest Number Of Points',
            onTap: () => _sortNewsByNumberOfPoints(
              descendant: true,
              allNews: allNews,
            ),
          ),
          _dropdownButton(
            name: 'Oldest Date Sort',
            onTap: () => _sortNewsByDate(
              allNews: allNews,
              descendant: false,
            ),
          ),
          _dropdownButton(
            name: 'Latest Date Sort',
            onTap: () => _sortNewsByDate(
              allNews: allNews,
              descendant: true,
            ),
          ),
        ],
      );

  Widget _dropdownButton({
    required String name,
    required Function() onTap,
  }) =>
      Button(
        name: name,
        shrink: true,
        color: Colors.black,
        margin: const EdgeInsets.all(4.5),
        bgrColor: const Color(0xFF9b9b9b),
        borderColor: Colors.white70,
        onTap: onTap,
      );

  Widget _scrollableList({required List<Widget> children}) => Expanded(
        child: Container(
          color: const Color(0xFF2C2B30),
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
