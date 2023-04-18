// ignore_for_file: unnecessary_null_comparison

import 'package:cine_app/src/models/movie_shows_model.dart';
import 'package:cine_app/src/pages/schedule_page/scroll_days_week.dart';
import 'package:cine_app/src/pages/schedule_page/search_movie.dart';
import 'package:cine_app/src/pages/schedule_page/show_schedule_empty.dart';
import 'package:cine_app/src/providers/show_provider.dart';
import 'package:flutter/material.dart';
import 'package:cine_app/src/commons/dates.dart';
import 'package:provider/provider.dart';

import 'cinema_show_list.dart';
import 'not_found.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late TextEditingController searchController;
  late DateTime selectedDate;
  late String dateCompleteSubtitle = "";
  late String daySelected;
  late String dateFormated;
  late List<dynamic> days;
  late ScrollController _scrollController;
  late bool existData;
  late Future<String?> currentLocalTime;
  late List<MovieShowsModel> movies;
  List<String> datesLoaded = [];
  List<dynamic> beforeSearchList = [];
  late Future<String> localDateTime;

  late Map<String, List<MovieShowsModel>> testData2;
  @override
  void initState() {
    DateTime date = DateTime.now();
    localDateTime = Dates.getCurrentDateAPI();
    selectedDate = date;
    Dates d = Dates(date);
    dateCompleteSubtitle = d.getDateSubtitle(date);
    daySelected = date.day.toString();
    dateFormated = Dates.castDateTimeToDateFormated(date);

    days = d.getWeek();

    _scrollController = ScrollController();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showProvider = context.watch<ShowProvider>();
    final getShows = showProvider.getShows(dateFormated);
    //print(getShows);
    if (getShows == 'Not fetched') {
      showProvider.fetchShowsByDate(dateFormated);
    }
    if (showProvider.shows![dateFormated] == "Empty") {
      movies = [];
      existData = false;
    } else {
      movies = showProvider.shows![dateFormated] ?? [];
    }
    existData = showProvider.shows![dateFormated] != null ? true : false;
    localDateTime = Dates.getCurrentDateAPI();
    if (searchController.text.isNotEmpty && existData) {
      final suggestions = movies.where((movie) {
        final movieTitle = movie.title.toString().toLowerCase();
        final input = searchController.text.toLowerCase();
        return movieTitle.contains(input);
      }).toList();
      setState(() {
        beforeSearchList = movies;
        movies = suggestions;
      });
    }
    void searchMovie(String query) {
      if (existData) {
        final suggestions = movies.where((movie) {
          final movieTitle = movie.title.toString().toLowerCase();
          final input = query.toLowerCase();
          return movieTitle.contains(input);
        }).toList();
        setState(() {
          beforeSearchList = movies;
          movies = suggestions;
        });
      }
    }

    void selectDay(String day, String daySubtitle, String dateForm,
        DateTime dateTime) async {
      setState(() {
        movies = showProvider.shows![dateForm] == null ||
                showProvider.shows![dateForm] == "Empty"
            ? []
            : showProvider.shows![dateForm];
        daySelected = day;
        dateCompleteSubtitle = daySubtitle;
        dateFormated = dateForm;
        selectedDate = dateTime;
        existData = showProvider.shows![dateForm] != null ? true : false;
      });
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      controller: _scrollController,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: Colors.white,
        height:
            movies.isNotEmpty ? null : MediaQuery.of(context).size.height * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchMovie(
              controller: searchController,
              dateFormated: dateFormated,
              onEditComplete: () => {
                if (searchController.text.isNotEmpty)
                  {searchMovie(searchController.text)}
                else
                  {setDefaultDateSelectedResults()}
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ScrollDaysWeek(
              days: days,
              daySelected: daySelected,
              selectDay: selectDay,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              dateCompleteSubtitle,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(
              height: 10,
            ),
            FutureBuilder(
              future: Future<String>.value(localDateTime),
              builder: (context, snapshot) {
                String localDateBolivia = '';
                if (snapshot.hasError) {
                  return const Center(
                    child: Text("No hay funciones disponibles"),
                  );
                } else if (snapshot.data != null) {
                  localDateBolivia =
                      // ignore: prefer_interpolation_to_compose_strings
                      snapshot.data.toString().substring(0, 10) +
                          " " +
                          snapshot.data.toString().substring(11, 26);
                }

                return showProvider.shows![dateFormated] != "Empty"
                    ? movies.isNotEmpty
                        ? CinemaShowList(
                            dateSelected: selectedDate,
                            currentDateTime: localDateBolivia == ''
                                ? DateTime.now()
                                : DateTime.parse(localDateBolivia),
                            movies: movies,
                            controller: _scrollController,
                          )
                        : const NoFoundResults()
                    : const ShowScheduleEmpty();
              },
            ),
          ],
        ),
      ),
    );
  }

  void setDefaultDateSelectedResults() {
    if (existData) {
      final showProvider = ShowProvider();
      setState(() {
        movies = showProvider.shows![dateFormated] ?? [];
      });
    }
  }
}
