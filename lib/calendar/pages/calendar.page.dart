import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// From this page we can filter the news by a specific day
// and show news only from that day.
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Calendar Page'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Go back to feed page'),
              ),
              ElevatedButton(
                onPressed: () => context.go('/favorites'),
                child: const Text('Go to favorites page'),
              ),
            ],
          ),
        ),
      );
}
