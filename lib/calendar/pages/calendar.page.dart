import 'package:flutter/material.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';

// From this page we can filter the news by a specific day
// and show news only from that day.
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: const Text('Calendar Page - WILL BE ADDED SOON'),
        children: <Widget>[
          _calendar(),
        ],
      );

  Widget _calendar() => Center(
        child: Container(
          width: 500,
          color: Colors.white,
          child: CalendarDatePicker(
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2100),
            onDateChanged: (_) {
              print('${_.month} -------------------------');
            },
          ),
        ),
      );
}
