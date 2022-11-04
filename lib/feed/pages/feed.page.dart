import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feed/models/news.model.dart';
import 'package:news_app/feed/services/news-pack.service.dart';
import 'package:news_app/shared/images/svg.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

// This is the main feed that is showing the latest news.
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  // TODO See in VS how it's done to set it with the value of the newsPack at the init moment.
  List<NewsM> filteredNews = [];

  @override
  void initState() {
    final newsPackService = Provider.of<NewsPackService>(
      context,
      listen: false,
    );
    newsPackService.getNewsPackM();
    filteredNews = [];
    super.initState();
  }

  // TODO Order method in this file by the order in the build method.
  @override
  Widget build(BuildContext context) {
    final newsPack = Provider.of<NewsPackService>(context);

    return PageShell(
      appBarChild: _searchBar(
        allNews: newsPack.newsPack.news,
      ),
      children: <Widget>[
        _buttonsCol(
          context,
        ),
        newsPack.loading
            ? _placeholder()
            : _scrollableList(
                children: [
                  for (final news in filteredNews)
                    _newsCard(
                      news: news,
                    ),
                ],
              ),
      ],
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

  // TODO Add null safety
  void _runFilter({
    required String enteredKeyword,
    required List<NewsM> allNews,
  }) {
    final List<NewsM> news;

    if (enteredKeyword.isEmpty) {
      // If the search field is empty or only contains white-space, we'll exit the method.
      return;
    } else {
      news = allNews
          .where((news) =>
              news.title!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // We use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      filteredNews = news;
    });
  }

  Widget _placeholder() => Container(
        width: 200,
        height: 200,
        color: Colors.red,
        child: const Text('Loading Data'),
      );

  Widget _buttonsCol(BuildContext context) => Column(
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

  Widget _scrollableList({required List<Widget> children}) => Expanded(
        child: Container(
          color: Colors.blue,
          child: ListView(
            controller: ScrollController(),
            children: children,
          ),
        ),
      );

  // TODO Remove the need for literals in sizes of this method.
  Widget _newsCard({required NewsM? news}) => Material(
        color: Colors.transparent,
        child: InkWell(
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(10),
            width: 400,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _title(
                  title: news?.title ?? '',
                ),
                _author(
                  author: news?.author ?? '',
                ),
                _numberOfComments(
                  commentsNum: news?.numberOfComments ?? 0,
                ),
                _numberOfPoints(
                  points: news?.numberOfPoints ?? 0,
                ),
                _publishDate(
                  date: news?.publishDate ?? '',
                ),
              ],
            ),
          ),
          onTap: () => _launchUrl(url: news?.url ?? ''),
        ),
      );

  // TODO Extract the method in a different file. Something like utils.
  Future<void> _launchUrl({required String url}) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }

  // TODO Add style
  Widget _title({required String title}) => Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      );

  // TODO Add style
  Widget _author({required String author}) => Text(
        author,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      );

  // TODO Add style and modify name of the method and break it into multiple ones??
  Widget _numberOfComments({required int commentsNum}) => Row(
        children: [
          Text(
            '$commentsNum',
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
          const Svg(
            height: 30,
            color: Colors.black,
            iconUrl: 'lib/assets/comments/comments-icon.svg',
          ),
        ],
      );

  // TODO Add own icon and make shared components with the comments method.
  Widget _numberOfPoints({required int points}) => Row(
        children: [
          Text(
            '$points',
            style: const TextStyle(
              color: Colors.brown,
            ),
          ),
          const Svg(
            iconUrl: 'lib/assets/comments/comments-icon.svg',
          ),
        ],
      );

  Widget _publishDate({required String date}) => Text(date);
}
