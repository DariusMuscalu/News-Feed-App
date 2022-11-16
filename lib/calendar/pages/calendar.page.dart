import 'package:flutter/material.dart';
import 'package:news_app/feed/providers/news-pack.provider.dart';
import 'package:news_app/shared/widgets/cards/news-card.dart';
import 'package:news_app/shared/widgets/pages/page-shell.dart';
import 'package:provider/provider.dart';

import '../../feed/models/news.model.dart';
import '../../shared/widgets/buttons/button.dart';

// From this page we can filter the news by a specific day
// and show news only from that day.
class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool _showCalendar = false;

  @override
  Widget build(BuildContext context) => PageShell(
        appBarChild: _appBarRow(),
        children: <Widget>[
          _calendar(),
          _newsBySelectedDate(),
        ],
      );

  Widget _appBarRow() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Calendar Page'),
          _openCalendarBtn(),
        ],
      );

  Widget _openCalendarBtn() => Button(
        bgrColor: Colors.white70,
        color: const Color(0xFF2C2B30),
        name: 'Select Date',
        onTap: () {
          _showCalendar = !_showCalendar;
          // Update the UI, TODO move it to state.
          setState(() {});
        },
      );

  Widget _calendar() => _showCalendar
      ? Consumer<NewsPackProvider>(
          builder: (context, newsPackProvider, children) {
            return Center(
              child: Container(
                width: 500,
                height: 200,
                color: const Color(0xFF2C2B30),
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  onDateChanged: (selectedDate) {
                    if (newsPackProvider.newsPack?.news != null) {
                      _runFilter(
                        allNews: newsPackProvider.newsPack!.news,
                        selectedDate: selectedDate,
                      );
                    }
                  },
                ),
              ),
            );
          },
        )
      : const SizedBox();

  Widget _newsBySelectedDate() => Consumer<NewsPackProvider>(
        builder: (context, newsPackProvider, children) {
          return newsPackProvider.filteredNewsBySelectedDate != null
              ? _scrollableList(
                  children: [
                    for (final news
                        in newsPackProvider.filteredNewsBySelectedDate!)
                      NewsCard(
                        news: news,
                      ),
                  ],
                )
              : const SizedBox();
        },
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

  void _runFilter({
    required List<NewsM> allNews,
    required DateTime selectedDate,
  }) {
    final List<NewsM> newsByDate = [];

    for (final news in allNews) {
      final newsDate = DateTime.parse(
        news.publishDate ?? '',
      );

      if (newsDate.year == selectedDate.year &&
          newsDate.month == selectedDate.month &&
          newsDate.day == selectedDate.day) {
        newsByDate.add(news);
      }
    }

    // Update the UI
    Provider.of<NewsPackProvider>(context, listen: false)
        .updateFilteredNewsBySelectedDate(
      news: newsByDate,
    );
  }
}
