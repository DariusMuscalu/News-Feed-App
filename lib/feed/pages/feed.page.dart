import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feed/services/news-pack.service.dart';
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
    final newsPackService =
        Provider.of<NewsPackService>(context, listen: false);
    newsPackService.getNewsPackM();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsPack = Provider.of<NewsPackService>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Feed page'),
      ),
      body: Center(
        child: Column(
          children: [
            newsPack.loading
                ? Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    child: const Text('Loading Data'),
                  )
                : Text(newsPack.newsPack?.news[0].author ?? 'Empty'),
            Column(
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
            ),
          ],
        ),
      ),
    );
  }
}
