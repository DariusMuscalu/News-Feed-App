import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_app/feed/models/news-pack.model.dart';
import 'package:news_app/feed/repositories/news-pack.repository.dart';

// This is the main feed that is showing the latest news.
class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Feed page'),
        ),
        body: Center(
          child: Column(
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
        ),
      );
}
