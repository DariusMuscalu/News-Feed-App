import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// This is the main feed that is showing the latest news.
class FeedPage extends StatelessWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
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
