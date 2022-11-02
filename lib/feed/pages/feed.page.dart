import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feed/models/news.model.dart';
import 'package:news_app/feed/services/news-pack.service.dart';
import 'package:provider/provider.dart';

import '../../shared/images/svg.dart';

// This is the main feed that is showing the latest news.
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  void initState() {
    final newsPackService =
        Provider.of<NewsPackService>(context, listen: false);
    newsPackService.getNewsPackM();
    super.initState();
  }

  // TODO Order method in this file by the order in the build method.
  @override
  Widget build(BuildContext context) {
    final newsPack = Provider.of<NewsPackService>(context);

    // TODO Make scaffold a shared component which is used in all pages, I think appbar should be contained too.
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Feed page'),
      ),
      body: Center(
        child: Column(
          children: [
            _buttonsCol(
              context,
            ),
            newsPack.loading
                ? _placeholder()
                : _scrollableList(
                    children: [
                      for (final news in newsPack.newsPack.news)
                        _newsCard(
                          news: news,
                        ),
                    ],
                  ),
          ],
        ),
      ),
    );
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
  Widget _newsCard({required NewsM? news}) => Container(
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
          ],
        ),
      );

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
}
