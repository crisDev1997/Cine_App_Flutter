import 'package:cine_app/src/services/show_service.dart';
import 'package:flutter/material.dart';

import '../models/movie_shows_model.dart';

class ShowProvider extends ChangeNotifier {
  dynamic _shows = {};
  dynamic get shows => _shows;
  dynamic getShows(date) {
    return _shows[date] ?? 'Not fetched';
  }

  Future<List<MovieShowsModel>?> fetchShowsByDate(date) async {
    try {
      if (_shows![date] != null) {
        return _shows![date];
      }
      final ShowService showService = ShowService();
      List<MovieShowsModel>? list = await showService.getShowsByDate(date);
      if (list != null) {
        _shows = {date: list};
      } else {
        _shows = {date: "Empty"};
      }
      notifyListeners();
      return list ?? [];
    } catch (e) {
      return [];
    }
  }
}
