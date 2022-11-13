import 'package:flutter/material.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';

// From this page we can filter the news by a specific day
// and show news only from that day.
class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Calendar Page - WILL BE ADDED SOON'),
        children: <Widget>[
          Center(
            child: Container(
              width: 500,
              color: Colors.white,
              child: CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
                onDateChanged: (_) {},
              ),
            ),
          ),
        ],
      );
}
